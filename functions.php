<?php

add_theme_support('post-thumbnails');

register_nav_menu('main-menu', 'Menú principal');

function isAjaxRequest(){
    if(strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest')
        return true;
    else
        return false;
}

#Echoes a json object with json headers
function jsonResponse($jsonArray){
    header('Content-type: application/json');
    $jsonResponse = json_encode($jsonArray);
    echo $jsonResponse;
}

function getNavMenu($sectionsArr) {
    $html = '';
    foreach($sectionsArr as $section){
        $html .= '<li>';
        $html .= '<a href="'. $section['route'] .'">';
        $html .= $section['label'];
        $html .= '</a>';
        $html .= '</li>';
    }
    return $html;
}

function getAttachmentData($id) {

    # Just a wrapper to rename this function that returns all the data from an attachment
    return wp_prepare_attachment_for_js($id);
}

function getGalleryThumbsArr($galleryIdString, $thumbSize = 'small') {

    if ($galleryIdString == '') return false;

    $idsArr = explode(',', $galleryIdString);
    $galleryArr = array();

    foreach ($idsArr as $id) {
        $galleryArr[] = array_shift(wp_get_attachment_image_src($id, $thumbSize));
    }
    return $galleryArr;
}


function getStylesheetUri() {
    return get_stylesheet_directory_uri() . '/';
}

function stylesheetUri() {
    echo getStylesheetUri();
}

function getThumbUrlArr($thumbnailSize = 'small') {
    $thumbId = get_post_thumbnail_id();
    $thumbUrl = wp_get_attachment_image_src($thumbId, $thumbnailSize, true);
    return $thumbUrl;
}

function getThumbUrl($thumbnailSize = 'small') {
    $thumbUrl = getThumbUrlArr($thumbnailSize);
    return $thumbUrl[0];
}

function getRoute() {
    $link = rtrim(get_permalink(), '/'); # We remove the last trailing slash
    return removeBaseUrl($link);
}

# Removes the site base url from the link, useful in our backbone routes, we can't use full urls but paths :)
function removeBaseUrl($permalink) {
    return str_replace(get_site_url(), '', $permalink);
}


function getYtEmbedUrl($ytLink) {
    $search = '#(.*?)(?:href="https?://)?(?:www\.)?(?:youtu\.be/|youtube\.com(?:/embed/|/v/|/watch?.*?v=))([\w\-]{10,12}).*#x';
    $replace = 'http://www.youtube.com/embed/$2';
    return preg_replace($search, $replace, $ytLink);
}

function getYtThumb($ytLink) {
    parse_str(parse_url($ytLink, PHP_URL_QUERY), $urlSegments);
    return "http://img.youtube.com/vi/{$urlSegments['v']}/2.jpg";
}

function placeTemplate($templateName, $data = array(), $args = array()) {
    $templatePath = 'templates/' . $templateName . '.php';
    return include($templatePath);
}

function theSectionDesc($pageSlug) {
    query_posts("pagename={$pageSlug}");
    if(have_posts()):
        while(have_posts()): the_post();
            $content = strip_shortcodes(get_the_content());
            $content = strip_tags($content);
            echo "<p class='sectionDesc'>{$content}</p>";
        endwhile;
    endif;
}

/*
 * @return array|false
 */
function getGallery($conf = array())
{
    /***
     *  Splits the ids from the shortCode placed in the content of a post, and gets the
     *  urls for the thumbnails and full
     *  img, as well as their titles, puts them in an array, and returns it.
     * @return Array || false
     *
     ***/

    $imgPerPage = $conf['imgPerPage'] ?: 10;
    $page = $conf['page'] ?: 1; # The page Number to retrieve
    $thumbSize = $conf['thumbSize'] ?: 'galleryThumb';
    $fullSize = $conf['fullSize'] ?: 'fullPic';

    $gallery = array(
        'meta' => array(
            'imgQ' => 0,
            'pagesQ' => 1
        ),
        'galleryItems' => array()
    );

    $content = get_the_content();
    if(empty($content))
        return false;

    $idsFromGallery = preg_replace('/[^0-9\,]/', '', $content);
    $imgIds = explode(',', $idsFromGallery);

    $startRange = ($page * $imgPerPage) - $imgPerPage;

    $imgIds = array_splice($imgIds, $startRange, $imgPerPage);

    if (count($imgIds) > 0) {

        foreach ($imgIds as $id) {
            $meta = getAttachmentData($id);
            $thumbUrl = wp_get_attachment_image_src($id, $thumbSize);
            $fullSizeUrl = wp_get_attachment_image_src($id, $fullSize);
            $gallery['galleryItems'][] = array(
                'title' => $meta['title'],
                'description' => $meta['description'],
                'thumbnail' => $thumbUrl[0],
                'fullImg' => $fullSizeUrl[0]
            );

        }

        return $gallery;
    } else {
        return false;
    }
}

/*
takes 3 parameters: trim length, more link text, and
content type (blank for excerpt or 'content' for content)
returns trimmed text block wrapped in <p> tags with a "more link" to post
*/
function customTextLenght($charlength, $more_link, $c_type = 'excerpt', $mode = 'raw', $post = NULL)
{
    if ($c_type == 'content') {
        $raw_text = (empty($post)) ? get_the_content() : $post->post_content;
    } else {
        $raw_text = (empty($post)) ? get_the_excerpt() : $post->post_excerpt;
    }
    $link = (empty($post)) ? '<a href="' . get_permalink() . '">' . $more_link . '</a>' : '<a href="' . get_permalink($post->ID) . '">' . $more_link . '</a>';
    if ($mode === 'raw') {
        $raw_text = strip_tags(str_replace('&nbsp;', '', $raw_text));
    }

    if (mb_strlen($raw_text) > $charlength) {
        $subex = mb_substr($raw_text, 0, $charlength - 5);
        $subex = '<p>' . $subex . '…' . $link . '</p>';
        $html = apply_filters('the_content', $subex);
        $filteredHtml = strip_tags($html, '<p><a><b><strong>');
        return $filteredHtml;
    } else {
        $raw_text = '<p>' . $raw_text . '…' . $link . '<p>';
        return $raw_text;
    }
}


// Limpia los imputs de los formularios enviados.

function sanitize($imput, $mode = "txt")
{
    $imput = trim($imput);
    $imput = strip_tags($imput);
    switch ($mode) {
        case "varchar":
            $healthy = preg_replace('/[^a-z A-Z-_]/', '', $imput);
            return $healthy;

        case "alpha":
            $healthy = preg_replace('/[^a-z A-Z]/', '', $imput);
            return $healthy;

            break;

        case "alnum":
            $healthy = preg_replace('/[^0-9 a-zA-Z]/', '', $imput);
            return $healthy;

            break;

        case "num":
            $healthy = preg_replace('/[^0-9]/', '', $imput);
            return $healthy;

            break;

        case "email":
            $healthy = trim(preg_replace('/[^0-9a-zA-Z_@.]/', '', $imput), " ");
            return $healthy;

            break;

        case "txt":
            $healthy = preg_replace('/[^a-z A-Z0-9@\'\"\.\,\#\%\(\)\$\/\:áéíóú&ñ\;\¿\?\!\¡\+\-\*\=]/', '', $imput);
            return $healthy;

            break;

    }
}

function getYoutubeEmbedUrl($youtubeUrl)
{
    $youtubeEmbed = str_replace('watch?v=', 'embed/', $youtubeUrl);
    $youtubeEmbed = preg_replace('/&feature.*/', '', $youtubeEmbed);
    $youtubeEmbed = preg_replace('/http./', '', $youtubeEmbed);
    return $youtubeEmbed;
}

/***********************************************************************************************************************************
 * El codigo a seguir cambia el comportamiento del crop de wp, y no cropea imagenes desde el centro, si no desde donde se le indique.
 ***********************************************************************************************************************************/

/* Example Usage:
 * bt_add_image_size( 'product-screenshot', 300, 300, array( 'left', 'top' ) );
 * bt_add_image_size( 'product-feature', 460, 345, array( 'center', 'top' ) );
 */

add_filter('intermediate_image_sizes_advanced', 'bt_intermediate_image_sizes_advanced');
add_filter('wp_generate_attachment_metadata', 'bt_generate_attachment_metadata', 10, 2);

/**
 * Registers a new image size with cropping positions
 *
 * The $crop parameter works as in the 'add_image_size' function taking true or
 * false values. If set to true, the default cropping position is 'center', 'center'.
 *
 * The $crop parameter also takes an array of the format
 * array( x_crop_position, y_crop_position )
 * x_crop_position can be 'left', 'center', 'right'
 * y_crop_position can be 'top', 'center', 'bottom'
 *
 * @param string $name Image size identifier.
 * @param int $width Image width.
 * @param int $height Image height.
 * @param bool|array $crop Optional, default is false. Whether to crop image to specified height and width or resize. An array can specify positioning of the crop area.
 * @return bool|array False, if no image was created. Metadata array on success.
 */
function bt_add_image_size($name, $width = 0, $height = 0, $crop = false)
{
    global $_wp_additional_image_sizes;
    $_wp_additional_image_sizes[$name] = array('width' => absint($width), 'height' => absint($height), 'crop' => $crop);
}


/**
 * Returning no sizes (an empty array) will force
 * wp_generate_attachment_metadata to skip creating intermediate image sizes on
 * upload, then we can run our own resizing functions by hooking into the
 * 'wp_generate_attachment_metadata' filter
 */
function bt_intermediate_image_sizes_advanced($sizes)
{
    return array();
}


function bt_generate_attachment_metadata($metadata, $attachment_id)
{
    $attachment = get_post($attachment_id);

    $uploadPath = wp_upload_dir();
    $file = path_join($uploadPath['basedir'], $metadata['file']);

    if (!preg_match('!^image/!', get_post_mime_type($attachment)) || !file_is_displayable_image($file)) return $metadata;

    global $_wp_additional_image_sizes;

    foreach (get_intermediate_image_sizes() as $s) {
        $sizes[$s] = array('width' => '', 'height' => '', 'crop' => FALSE);
        if (isset($_wp_additional_image_sizes[$s]['width']))
            $sizes[$s]['width'] = intval($_wp_additional_image_sizes[$s]['width']); // For theme-added sizes
        else
            $sizes[$s]['width'] = get_option("{$s}_size_w"); // For default sizes set in options
        if (isset($_wp_additional_image_sizes[$s]['height']))
            $sizes[$s]['height'] = intval($_wp_additional_image_sizes[$s]['height']); // For theme-added sizes
        else
            $sizes[$s]['height'] = get_option("{$s}_size_h"); // For default sizes set in options
        if (isset($_wp_additional_image_sizes[$s]['crop']))
            $sizes[$s]['crop'] = $_wp_additional_image_sizes[$s]['crop'];
        else
            $sizes[$s]['crop'] = get_option("{$s}_crop");
    }

    foreach ($sizes as $size => $size_data) {
        $resized = bt_image_make_intermediate_size($file, $size_data['width'], $size_data['height'], $size_data['crop']);
        if ($resized)
            $metadata['sizes'][$size] = $resized;
    }

    return $metadata;
}


/**
 * Resize an image to make a thumbnail or intermediate size.
 *
 * The returned array has the file size, the image width, and image height. The
 * filter 'image_make_intermediate_size' can be used to hook in and change the
 * values of the returned array. The only parameter is the resized file path.
 *
 * @param string $file File path.
 * @param int $width Image width.
 * @param int $height Image height.
 * @param bool|array $crop Optional, default is false. Whether to crop image to specified height and width or resize. An array can specify positioning of the crop area.
 * @return bool|array False, if no image was created. Metadata array on success.
 */
function bt_image_make_intermediate_size($file, $width, $height, $crop = false)
{
    if ($width || $height) {
        $resized_file = bt_image_resize($file, $width, $height, $crop, null, null, 90);
        if (!is_wp_error($resized_file) && $resized_file && $info = getimagesize($resized_file)) {
            $resized_file = apply_filters('image_make_intermediate_size', $resized_file);
            return array(
                'file' => wp_basename($resized_file),
                'width' => $info[0],
                'height' => $info[1],
            );
        }
    }
    return false;
}


/**
 * Retrieve calculated resized dimensions for use in imagecopyresampled().
 *
 * Calculate dimensions and coordinates for a resized image that fits within a
 * specified width and height. If $crop is true, the largest matching central
 * portion of the image will be cropped out and resized to the required size.
 *
 * @param int $orig_w Original width.
 * @param int $orig_h Original height.
 * @param int $dest_w New width.
 * @param int $dest_h New height.
 * @param bool $crop Optional, default is false. Whether to crop image or resize.
 * @return bool|array False, on failure. Returned array matches parameters for imagecopyresampled() PHP function.
 */
function bt_image_resize_dimensions($orig_w, $orig_h, $dest_w, $dest_h, $crop = false)
{

    if ($orig_w <= 0 || $orig_h <= 0)
        return false;
    // at least one of dest_w or dest_h must be specific
    if ($dest_w <= 0 && $dest_h <= 0)
        return false;

    if ($crop) {
        // crop the largest possible portion of the original image that we can size to $dest_w x $dest_h
        $aspect_ratio = $orig_w / $orig_h;
        $new_w = min($dest_w, $orig_w);
        $new_h = min($dest_h, $orig_h);

        if (!$new_w) {
            $new_w = intval($new_h * $aspect_ratio);
        }

        if (!$new_h) {
            $new_h = intval($new_w / $aspect_ratio);
        }

        $size_ratio = max($new_w / $orig_w, $new_h / $orig_h);

        $crop_w = round($new_w / $size_ratio);
        $crop_h = round($new_h / $size_ratio);

        if (!is_array($crop) || count($crop) != 2) {
            $crop = apply_filters('image_resize_crop_default', array('center', 'center'));
        }

        switch ($crop[0]) {
            case 'left':
                $s_x = 0;
                break;
            case 'right':
                $s_x = $orig_w - $crop_w;
                break;
            default:
                $s_x = floor(($orig_w - $crop_w) / 2);
        }

        switch ($crop[1]) {
            case 'top':
                $s_y = 0;
                break;
            case 'bottom':
                $s_y = $orig_h - $crop_h;
                break;
            default:
                $s_y = floor(($orig_h - $crop_h) / 2);
        }
    } else {
        // don't crop, just resize using $dest_w x $dest_h as a maximum bounding box
        $crop_w = $orig_w;
        $crop_h = $orig_h;

        $s_x = 0;
        $s_y = 0;

        list($new_w, $new_h) = wp_constrain_dimensions($orig_w, $orig_h, $dest_w, $dest_h);
    }

    // if the resulting image would be the same size or larger we don't want to resize it
    if ($new_w >= $orig_w && $new_h >= $orig_h)
        return false;

    // the return array matches the parameters to imagecopyresampled()
    // int dst_x, int dst_y, int src_x, int src_y, int dst_w, int dst_h, int src_w, int src_h
    return array(0, 0, (int)$s_x, (int)$s_y, (int)$new_w, (int)$new_h, (int)$crop_w, (int)$crop_h);

}


/**
 * Scale down an image to fit a particular size and save a new copy of the image.
 *
 * The PNG transparency will be preserved using the function, as well as the
 * image type. If the file going in is PNG, then the resized image is going to
 * be PNG. The only supported image types are PNG, GIF, and JPEG.
 *
 * Some functionality requires API to exist, so some PHP version may lose out
 * support. This is not the fault of WordPress (where functionality is
 * downgraded, not actual defects), but of your PHP version.
 *
 * @since 2.5.0
 *
 * @param string $file Image file path.
 * @param int $max_w Maximum width to resize to.
 * @param int $max_h Maximum height to resize to.
 * @param bool $crop Optional. Whether to crop image or resize.
 * @param string $suffix Optional. File Suffix.
 * @param string $dest_path Optional. New image file path.
 * @param int $jpeg_quality Optional, default is 90. Image quality percentage.
 * @return mixed WP_Error on failure. String with new destination path.
 */
function bt_image_resize($file, $max_w, $max_h, $crop = false, $suffix = null, $dest_path = null, $jpeg_quality = 90)
{

    $image = wp_load_image($file);
    if (!is_resource($image))
        return new WP_Error('error_loading_image', $image, $file);

    $size = @getimagesize($file);
    if (!$size)
        return new WP_Error('invalid_image', __('Could not read image size'), $file);
    list($orig_w, $orig_h, $orig_type) = $size;

    // Rotate if EXIF 'Orientation' is set
    // This code is from the reverted patch at
    // http://core.trac.wordpress.org/changeset/11746/trunk/wp-includes/media.php
    $rotate = false;
    if (is_callable('exif_read_data') && in_array($orig_type, apply_filters('wp_read_image_metadata_types', array(IMAGETYPE_JPEG, IMAGETYPE_TIFF_II, IMAGETYPE_TIFF_MM)))) {
        $exif = @exif_read_data($file, null, true);
        if ($exif && isset($exif['IFD0']) && is_array($exif['IFD0']) && isset($exif['IFD0']['Orientation'])) {
            if (6 == $exif['IFD0']['Orientation'])
                $rotate = 90;
            elseif (8 == $exif['IFD0']['Orientation'])
                $rotate = 270;
        }
    }

    if ($rotate)
        list($max_h, $max_w) = array($max_w, $max_h);

    $dims = bt_image_resize_dimensions($orig_w, $orig_h, $max_w, $max_h, $crop);
    if (!$dims)
        return new WP_Error('error_getting_dimensions', __('Could not calculate resized image dimensions'));
    list($dst_x, $dst_y, $src_x, $src_y, $dst_w, $dst_h, $src_w, $src_h) = $dims;

    $newimage = wp_imagecreatetruecolor($dst_w, $dst_h);

    if ($rotate)
        list($src_y, $src_x) = array($src_x, $src_y);

    imagecopyresampled($newimage, $image, $dst_x, $dst_y, $src_x, $src_y, $dst_w, $dst_h, $src_w, $src_h);

    // convert from full colors to index colors, like original PNG.
    if (IMAGETYPE_PNG == $orig_type && function_exists('imageistruecolor') && !imageistruecolor($image))
        imagetruecolortopalette($newimage, false, imagecolorstotal($image));

    // we don't need the original in memory anymore
    imagedestroy($image);

    // $suffix will be appended to the destination filename, just before the extension
    if (!$suffix) {
        if ($rotate)
            $suffix = "{$dst_h}x{$dst_w}";
        else
            $suffix = "{$dst_w}x{$dst_h}";
    }

    $info = pathinfo($file);
    $dir = $info['dirname'];
    $ext = $info['extension'];
    $name = wp_basename($file, ".$ext");

    if (!is_null($dest_path) and $_dest_path = realpath($dest_path))
        $dir = $_dest_path;
    $destfilename = "{$dir}/{$name}-{$suffix}.{$ext}";

    if (IMAGETYPE_GIF == $orig_type) {
        if (!imagegif($newimage, $destfilename))
            return new WP_Error('resize_path_invalid', __('Resize path invalid'));
    } elseif (IMAGETYPE_PNG == $orig_type) {
        if (!imagepng($newimage, $destfilename))
            return new WP_Error('resize_path_invalid', __('Resize path invalid'));
    } else {
        if ($rotate) {
            $newimage = _rotate_image_resource($newimage, 360 - $rotate);
        }

        // all other formats are converted to jpg
        $destfilename = "{$dir}/{$name}-{$suffix}.jpg";
        $return = imagejpeg($newimage, $destfilename, apply_filters('jpeg_quality', $jpeg_quality, 'image_resize'));
        if (!$return)
            return new WP_Error('resize_path_invalid', __('Resize path invalid'));
    }

    imagedestroy($newimage);

    // Set correct file permissions
    $stat = stat(dirname($destfilename));
    $perms = $stat['mode'] & 0000666; //same permissions as parent folder, strip off the executable bits
    @ chmod($destfilename, $perms);

    return $destfilename;
}

## Used by bio.php
bt_add_image_size('bioThumb', 216, 216, array('center', 'top'));

## Used by gallery.php (fotos/videos)
bt_add_image_size('galleryThumb', 140, 140, array('center', 'top'));
bt_add_image_size('fullPic', 800, 800, array('center', 'top'));

/*bt_add_image_size('mainSlider', 940, 325, array('center', 'top'));
bt_add_image_size('bioThumbs', 256, 193, array('center', 'top'));
bt_add_image_size('homeFeed', 169, 169, array('center', 'top'));


## Used by blog-section.php and news-section.php
bt_add_image_size('blogExcerpt', 182, 166, array('center', 'top'));
bt_add_image_size('singleBlog', 800, 300, array('center', 'center'));*/
?>
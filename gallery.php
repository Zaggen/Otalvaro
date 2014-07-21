<?php
/*
 * Template Name: Gallery
 * */
$page = $page ?: 1;
$baseUri = getStylesheetUri();
$galConf = array(
    'imgPerPage' => 36,
    'page' => $page
);

# We get our gallery array, which contains all the images data for the specified page (using the $galConf)
$gallery = array();
if(have_posts()):
    while(have_posts()): the_post();
        $gallery = getGallery($galConf);
    endwhile;
endif;


if (isAjaxRequest()) {

    $response = array(
        'collection' => $gallery['galleryItems'],
        'pageQ' => $gallery['meta']['pageQ']
    );

    jsonResponse($response);
} else {
    get_header();
?>
    <div id="galleryContent" class="grid">
        <h2 class="navCrumb bioCrumb">Fotos  <i class="fa fa-camera"></i> </h2>
        <ul class="gallery">
            <?php
            $i = 0;
            foreach($gallery['galleryItems'] as $img){
                echo "<li>
                        <a href='{$img['title']}'>
                           <img src='{$img['thumbnail']}' data-index='{$i}'/>
                        </a>
                     </li>";
                $i++;
            }
            ?>

        </ul>
    </div>

    <ul id="galNavi" class="pageNavi" data-page-quantity="<?= $gallery['meta']['pageQ']; ?>"></ul>

<?php
    get_footer();
}
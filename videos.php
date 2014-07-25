<?php
/*
 * Template Name: Videos
 * */

# Get all video galleries and set an array
$page = $page ?: 1;
$videoGallery = array();
query_posts(array('post_type' => 'video', 'paged' => $page));
while(have_posts()):
    if(have_posts()): the_post();
        $videoGallery[] = array(
            'title' => get_the_title(),
            'url' => getYtEmbedUrl(get_the_excerpt()),
            'thumbnail' => getYtThumb(get_the_excerpt())
        );
    endif;
endwhile;


if (isAjaxRequest()) {

    $response = array(
        'collection' => $videoGallery,
        'pageQ' => 4
    );

    jsonResponse($response);
} else {
    get_header();
    ?>
    <div id="galleryContent" class="grid">
        <h2 class="navCrumb bioCrumb">Videos  <i class="fa fa-film"></i> </h2>
        <ul class="gallery transitionAll">
            <?php
            $i = 0;
            foreach($videoGallery as $video){
                echo "<li>
                        <a href='{$video['title']}'>
                           <img src='{$video['thumbnail']}' data-index='{$i}'/>
                        </a>
                     </li>";
                $i++;
            }
            ?>

        </ul>
    </div>

    <ul id="galNavi" class="pageNavi" data-page-quantity="<?= 4; ?>"></ul>
    <?php
    get_footer();
}
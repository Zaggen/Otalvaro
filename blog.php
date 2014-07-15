<?php
/*
 * Template Name: Blog
 */

$title = '';
$content = '';
$profileImg = '';
$rating = 5;
$permalink = '';
$thumbnail = '';
$date = 'julio 25, 2014';
$entries = array();
query_posts(array('post_type' => 'post'));
if(have_posts()):
    while(have_posts()): the_post();
        $rating = 5;
        $permalink = get_permalink();

        $thumbId = get_post_thumbnail_id();
        $thumbUrlArray = wp_get_attachment_image_src($thumbId, 'bioThumb', true);
        $thumbnail = $thumbUrlArray[0];

        $entries[] = array(
            'title' => get_the_title(),
            'content' => get_the_content(),
            'excerpt' => get_the_excerpt(),
            'thumbnail' => $thumbnail,
            'date' => $date
        );

    endwhile;
endif;

if(isAjaxRequest()) {

    jsonResponse($entries);

}else{

get_header(); ?>
    <h2 class="navCrumb bioCrumb">Blog
        <i class="fa fa-book"></i>
    </h2>
    <ul>
    <?php foreach($entries as $entry): extract($entry)?>
        <li class="grid entryFeed">
            <figure class="entryThumb"><a><img src="<?= $thumbnail; ?>"/></a></figure>
            <h3 class="entryTitle"><?= $title; ?></h3><span class="publishDate"><?= $date; ?></span>
            <ul class="starRating">
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
            </ul>
            <div class="feedText"><?= $excerpt; ?></div>
        </li>
    <?php endforeach; ?>

    </ul>
    <ul id="newsNavi" class="pageNavi">
        <li class="navBtns selectedNav">1</li>
        <li class="navBtns">2</li>
        <li class="navBtns">3</li>
        <li class="navBtns">4</li>
    </ul>
    <?php
    get_footer();
}
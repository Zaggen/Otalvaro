<?php
if(have_posts()):
    while(have_posts()): the_post();

        $thumbId = get_post_thumbnail_id();
        $featuredImageArr = wp_get_attachment_image_src($thumbId, 'singleEntry', true);
        $featuredImage = $featuredImageArr[0];

        $response = array(
            'title' => get_the_title(),
            'content' => apply_filters( 'the_content',get_the_content() ),
            'featuredImage' => $featuredImage,
            'date' => get_the_date()
        );
    endwhile;
endif;


if (isAjaxRequest()) {
        jsonResponse($response);
} else {
    get_header();
    if(isset($response)):
        extract($response) ?>
        <div id="singleEntry">
            <h1 class="navCrumb">
                <?= $title; ?>
                <i class="fa fa-file-text"></i>
            </h1>
            <span class="publishDate"><?= $date; ?></span>
            <ul class="starRating">
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
                <li><i class="fa fa-star"></i></li>
            </ul>
            <figure>
                <img src="<?= $featuredImage; ?>" class="featuredImg"/>
            </figure>            
            <p>
                <?= $content; ?>
            </p>
        </div>
    <?php
    else:
        echo "<span>Entrada no encontrada, intenta con otro articulo</span>";
    endif;
    get_footer();
}
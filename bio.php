<?php
/*
 * Template Name: Bio
 */

$title = '';
$content = '';
$profileImg = '';

if(have_posts()):
    while(have_posts()): the_post();
        $title = get_the_title();
        $content = get_the_content();

        $thumbId = get_post_thumbnail_id();
        $thumbUrlArray = wp_get_attachment_image_src($thumbId, 'bioThumb', true);
        $profileImg = $thumbUrlArray[0];

    endwhile;
endif;

if(isAjaxRequest()) {

    $data = array(
        'title' => $title,
        'content' => $content,
        'profileImg' => $profileImg
    );

    jsonResponse($data);

}else{

    get_header(); ?>
        <div class="col_8">
            <h2 class="navCrumb bioCrumb"><?= $title; ?>
                <i class="fa fa-user"></i>
            </h2>
            <p id="bioContent"><?= $content; ?></p>
        </div>
        <div id="bioDetails" class="col_4"><h2 class="navCrumb">Perfil de Cata</h2>
            <figure id="bioPicture">
                <img src="<?= $profileImg; ?>"/>
            </figure>
            <ul class="bioDetailsData">
                <li><strong>Estatura:</strong> 170</li>
                <li>
                    <ul class="meassures">
                        <li><strong>Busto:</strong> 90cm</li>
                        <li><strong>Cintura:</strong> 60cm</li>
                        <li><strong>Cadera:</strong> 90cm</li>
                    </ul>
                </li>
                <li><strong>Edad:</strong> 23 Años</li>
                <li><strong>Graduada en:</strong> Admistración</li>
                <li><strong>Mascotas:</strong> Roger (Labrador)</li>
                <li><strong>Años de modelaje:</strong> 6</li>
            </ul>
        </div>
    <?php
    get_footer();
}

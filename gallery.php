<?php
/*
 * Template Name: Gallery
 * */
$baseUri = getStylesheetUri();
$gallery = array(
    'images' => array(
        $baseUri . 'imgs/gallery/0.jpg',
        $baseUri . 'imgs/gallery/1.jpg',
        $baseUri . 'imgs/gallery/2.jpg',
        $baseUri . 'imgs/gallery/3.jpg',
        $baseUri . 'imgs/gallery/4.jpg',
        $baseUri . 'imgs/gallery/5.jpg',
        $baseUri . 'imgs/gallery/6.jpg',
        $baseUri . 'imgs/gallery/7.jpg',
        $baseUri . 'imgs/gallery/8.jpg',
        $baseUri . 'imgs/gallery/9.jpg',
        $baseUri . 'imgs/gallery/10.jpg',
        $baseUri . 'imgs/gallery/11.jpg',
        $baseUri . 'imgs/gallery/0.jpg',
        $baseUri . 'imgs/gallery/1.jpg',
        $baseUri . 'imgs/gallery/2.jpg',
        $baseUri . 'imgs/gallery/3.jpg',
        $baseUri . 'imgs/gallery/4.jpg',
        $baseUri . 'imgs/gallery/5.jpg',
        $baseUri . 'imgs/gallery/6.jpg',
        $baseUri . 'imgs/gallery/7.jpg',
        $baseUri . 'imgs/gallery/8.jpg',
        $baseUri . 'imgs/gallery/9.jpg',
        $baseUri . 'imgs/gallery/10.jpg',
        $baseUri . 'imgs/gallery/11.jpg',
        $baseUri . 'imgs/gallery/0.jpg',
        $baseUri . 'imgs/gallery/1.jpg',
        $baseUri . 'imgs/gallery/2.jpg',
        $baseUri . 'imgs/gallery/3.jpg',
        $baseUri . 'imgs/gallery/4.jpg',
        $baseUri . 'imgs/gallery/5.jpg',
        $baseUri . 'imgs/gallery/6.jpg',
        $baseUri . 'imgs/gallery/7.jpg',
        $baseUri . 'imgs/gallery/8.jpg',
        $baseUri . 'imgs/gallery/9.jpg',
        $baseUri . 'imgs/gallery/10.jpg',
        $baseUri . 'imgs/gallery/11.jpg'
    )
);

if (isAjaxRequest()) {
    jsonResponse($gallery);
} else {
    get_header();
?>

    <h2 class="navCrumb bioCrumb">Fotos  <i class="fa fa-camera"></i> </h2>
    <ul class="gallery">
        <?php
        foreach($gallery['images'] as $img){
            echo "<li><img src='{$img}'/></li>";
        }
        ?>

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
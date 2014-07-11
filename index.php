<?php

$quote = '';

if (have_posts()):
    while (have_posts()): the_post();
        $quote = get_the_content();
    endwhile;
endif;


if (isAjaxRequest()) {
        jsonResponse( array('quote' => $quote) );
} else {

    get_header(); ?>
        <blockquote id="homeQuote"><p>I loved you yesterday, I love you still, I always have... I always will</p>
            <footer>Catalina Otalvaro</footer>
        </blockquote>
        <div class="twitterFeed fadeIn">
            <a href="https://twitter.com/kataotalvaro" data-widget-id="481647155510140928" class="twitter-timeline">Tweets by @kataotalvaro</a>
        </div>
    <?php
    get_footer();
}

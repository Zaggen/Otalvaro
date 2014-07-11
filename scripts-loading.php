<!-- Footer Scripts-->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
    !function(){
        if (matchMedia('only screen and (min-width: 680px)').matches) {
            $.getScript('<?php stylesheetUri(); ?>js/lib/coffee-drag-slider.js');
        }
    }()
</script>

<script src="//platform.twitter.com/widgets.js"></script>

<!--<script src="<?php /*stylesheetUri(); */?>js/lib/coffee-drag-slider.js"></script>-->

<?php include_once('underscore-templates.php'); ?>

<script src="<?php stylesheetUri(); ?>js/lib/underscore-min.js"></script>
<script src="<?php stylesheetUri(); ?>js/lib/backbone.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/2.0.0-alpha.4/handlebars.min.js"></script>

<!--script(src='//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js')-->
<!--script(src='//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min.js')-->

<script src="<?php stylesheetUri(); ?>js/src/init.js"></script>

<!-- Models -->
<script src="<?php stylesheetUri(); ?>js/src/models/home.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/models/bio.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/models/blog.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/models/gallery.js"></script>

<!-- Views-->
<script src="<?php stylesheetUri(); ?>js/src/views/base-content.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/navigator.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/sliderCover.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/main-layout.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/home.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/bio.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/base-collection.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/blog.js"></script>
<script src="<?php stylesheetUri(); ?>js/src/views/gallery.js"></script>

<!-- Routers-->
<script src="<?php stylesheetUri(); ?>js/src/routers/app.js"></script>

<script id="homeTemplate" type="text/x-handlebars-template">
    <blockquote id="homeQuote"><p>I loved you yesterday, I love you still, I always have... I always will</p>
        <footer>Catalina Otalvaro</footer>
    </blockquote>
    <div class="twitterFeed fadeIn">
        <a href="https://twitter.com/kataotalvaro" data-widget-id="481647155510140928" class="twitter-timeline">Tweets by @kataotalvaro</a>
    </div>
</script>

<script id="bioTemplate" type="text/x-handlebars-template">
    <div class="col_8">
        <h2 class="navCrumb bioCrumb">{{ title }}
        <i class="fa fa-user"></i>
        </h2>
        <p id="bioContent">{{ content }}</p>
    </div>
    <div id="bioDetails" class="col_4"><h2 class="navCrumb">Perfil de Cata</h2>
        <figure id="bioPicture">
            <img src="{{ profileImg }}"/>
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
</script>

<script id="galleryTemplate" type="text/x-handlebars-template">
    <h2 class="navCrumb bioCrumb">Fotos  <i class="fa fa-camera"></i> </h2>
    <ul class="gallery">
        {{#each galleryItems}}
            <li><a href="{{this.fullImg}}" title="{{this.title}}"><img src="{{this.thumbnail}} "/></a></li>
        {{/each}}
    </ul>
 </script>

<script id="blogTemplate" type="text/x-handlebars-template">
    <h2 class="navCrumb bioCrumb">Blog
        <i class="fa fa-book"></i>
    </h2>
</script>

<script id="blogEntryTemplate" type="text/x-handlebars-template">
    <figure class="entryThumb"><a><img src="{{this.thumbnail}}"/></a></figure>
    <h3 class="entryTitle">{{this.title}}</h3><span class="publishDate">{{this.date}}</span>
    <ul class="starRating">
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
    </ul>
    <div class="feedText">{{this.excerpt}}</div>
</script>

<!-- HOME TEMPLATE -->
<script id="homeTemplate" type="text/x-handlebars-template">
    <blockquote id="homeQuote"><p>I loved you yesterday, I love you still, I always have... I always will</p>
        <footer>Catalina Otalvaro</footer>
    </blockquote>
    <div class="twitterFeed fadeIn">
        <a href="https://twitter.com/kataotalvaro" data-widget-id="481647155510140928" class="twitter-timeline">Tweets by @kataotalvaro</a>
    </div>
</script>

<!-- BIO TEMPLATE -->
<script id="bioTemplate" type="text/x-handlebars-template">
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
    <div class="col_8 bioCol">
        <h2 class="navCrumb bioCrumb">{{ title }}
            <i class="fa fa-user"></i>
        </h2>
        <p id="bioContent">{{{ content }}}</p>
    </div>
</script>


<!-- BLOG TEMPLATES -->
<script id="blogTemplate" type="text/x-handlebars-template">
    <h2 class="navCrumb bioCrumb">Blog<i class="fa fa-book"></i></h2>
    <ul id="blogFeed"></ul>
</script>

<script id="blogEntryTemplate" type="text/x-handlebars-template">
    <figure class="entryThumb">
        <a href="{{permalink}}"><img src="{{this.thumbnail}}"/></a>
    </figure>
    <a href="{{permalink}}">
        <h3 class="entryTitle">{{this.title}}</h3>
    </a>
    <span class="publishDate">{{this.date}}</span>
    <ul class="starRating">
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
    </ul>
    <div class="feedText">{{{this.excerpt}}}</div>
</script>


<!-- SINGLE BLOG ENTRY(FULL) TEMPLATE -->
<script id="singleEntryTemplate" type="text/x-handlebars-template">
    <h1 class="navCrumb">{{title}}<i class="fa fa-file-text"></i></h1>
    <span class="publishDate">{{date}}</span>
    <ul class="starRating">
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
        <li><i class="fa fa-star"></i></li>
    </ul>
    <figure>
        <img src="{{featuredImage}}" class="featuredImg"/>
    </figure>
    <p>{{{content}}}</p>
</script>

<!-- GALLERY TEMPLATE -->
<script id="galleryTemplate" type="text/x-handlebars-template">
    <h2 class="navCrumb bioCrumb">Fotos  <i class="fa fa-camera"></i> </h2>
    <ul class="gallery transitionAll">
        {{#each galleryItems}}
        <li>
            <a href="{{this.fullImg}}" title="{{this.title}}">
                <img src="{{this.thumbnail}} " data-index="{{@index}}"/>
            </a>
        </li>
        {{/each}}
    </ul>
</script>


<!-- VIDEO GALLERY TEMPLATE -->
<script id="videoGalleryTemplate" type="text/x-handlebars-template">
    <h2 class="navCrumb bioCrumb">Videos  <i class="fa fa-film"></i> </h2>
    <ul class="gallery transitionAll">
        {{#each galleryItems}}
        <li>
            <a href="{{this.embedUrl}}" title="{{this.title}}">
                <img src="{{this.thumbnail}} " data-index="{{@index}}"/>
            </a>
        </li>
        {{/each}}
    </ul>
</script>

<!-- LIGHTBOX TEMPLATE -->
<script id="lightBoxTemplate" type="text/x-handlebars-template">
    <div class="overlay"></div>
    <div class="prevBtn"><i class="fa fa-angle-left"></i></div>
    <div class="nextBtn"><i class="fa fa-angle-right"></i></div>
    <div class="Window">
        <div class="closeBtn"></div>
        <div class="progress">
            <div>Loading…</div>
        </div>
        <div id="lightboxContent"></div>
    </div>
</script>

<!-- CONTACT TEMPLATE -->
<script id="contactTemplate" type="text/x-handlebars-template">
    <div id="contactFormWrapper" class="col_5">
        <h2 class="navCrumb bioCrumb">Contacto  <i class="fa fa-envelope"></i></h2>
        <div class="alert hidden"></div>
        <form action="/mail-sender">
            <input type="text" name="nombre" class="contactInput" placeholder="Nombre" required="required"/>
            <input type="email" name="correo" class="contactInput" placeholder="Correo" required="required"/>
            <input type="text" name="asunto" class="contactInput" placeholder="Asunto" required="required"/>
            <textarea name="mensaje" id="msg" class="contactInput" cols="30" rows="10" placeholder="Mensaje" required="required"></textarea>
            <input type="submit" class="submitBtn" value="Enviar" id="contactSubmit"/>
        </form>
    </div>
    <div id="contactDetailsWrapper" class="col_7">
        <div class="col_12">
            <div class="col_7">
                <h4 id="contactDataTitle">Datos de contacto</h4>
                <ul id="contactDetails">
                    {{#each details}}
                        <li><strong>{{this.fieldName}}:</strong> {{this.value}}</li>
                    {{/each}}
                </ul>
            </div>
            <figure class="col_5">
                <img src="{{featuredImage}}"/>
            </figure>
        </div>
        <div class="col_12">
            <p id="contactMessage">{{{contactMsg}}}</p>
        </div>
    </div>
</script>
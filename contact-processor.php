<?php
/*
 * Template Name: Contact Processor
 * */

header('content-type: application/json; charset=ISO-8859-1');

if(!empty($_POST['nombre']) and !empty($_POST['mensaje'])){

    // We take the data that came from POST and sanitize it.

    $nombre = sanitize($_POST['nombre'], 'alpha');
    $correo = sanitize($_POST['correo'], 'email');
    $asunto = sanitize($_POST['asunto'], 'varchar');
    $mensaje = sanitize($_POST['mensaje'], 'txt');

    if(have_posts()):
        while(have_posts()): the_post();
            $to = get_the_content();
        endwhile;
    endif;

    $to = $to ?: '';
    $subject = "contacto";

    $body =
        "<p>Te han enviado un mensaje desde tu web, revisa aqui tu mensaje:</p>
        <p><strong>Nombre:</strong>{$nombre}</p>
        <p><strong>Correo:</strong>{$correo}</p>
        <p><strong>Asunto:</strong>{$asunto}</p>
        <p><strong>Mensaje:</strong>{$mensaje}";

    $headers[] =  'From: Catalina Otalvaro Website <no-reply@catalinaotalvaro.me/>';
    $headers[] = 'Reply-To: no-reply@catalinaotalvaro.me';
    $headers[] = 'Content-type: text/html';

    if(wp_mail($to, $subject, $body, $headers)){
        $msg = array(
            'status' => 'success',
            'title' => 'Gracias',
            'description' => 'Tu mensaje fue enviado con exito'
        );
    }else{
        $msg = array(
            'status' => 'failed',
            'title' => 'Lo sentimos',
            'description' => 'El mensaje no pudo ser enviado, intenta nuevamente'
        );
    }

}else{
    $msg = array(
        'status' => 'failed',
        'title' => 'Ups',
        'description' => 'No llenaste todos los campos, intentalo otra vez'
    );
}

echo json_encode($msg);
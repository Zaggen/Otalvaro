root = window ? global
Otalvaro = root.Otalvaro

# Contact Form View

class Otalvaro.Views.Contact extends Otalvaro.Views.BaseContent
  template: root.template('contactTemplate')

  initialize: ->
    super
    if $('#contactWrapper')[0]?
      @setElement('#contactWrapper')

    @$alert =  $( @$el.find('.alert') )

  events:
    'submit': 'contactHandler'

  contactHandler: (e)=>
    e.preventDefault()
    @$form ?= @$el.find('form')
    @postUrl ?= @$form.attr( 'action' )
    @sendForm( @$form.serialize() )

  sendForm: (data)->
    console.log 'data', data
    console.log '--------------'
    console.log '@postUrl', @postUrl
    console.log '--------------'
    $.ajax
      type: 'POST'
      url: @postUrl
      data: data

      success: ( response )=>
        @$el.before @setMsgAlert(response)
        if response.status is 'success'
          @$el.addClass 'setOpacityTenPercent'
          @$el.find('#contactSubmit').remove()

      error: =>
        msgObj =
          status: 'failed'
          title: 'Error de conexión'
          description: 'Hubo un problema al intenta enviar tu mensaje, intentalo mas tarde'

        @$el.before @setMsgAlert(msgObj)

  setMsgAlert: (response)->
    console.log response
    alertClass = 'alert ' + if response.status is 'success' then 'alertSuccess' else 'alertDanger'
    @$alert
    .removeClass()
    .addClass(alertClass)
    .html('<strong>' + response.title + '</strong> ' + response.description)

  window.checkarr = []
  spanCheckInit = ->
    $('span.label.span12 .pull-right').remove()
    $('span.label.span12:not(.default)').removeClass('label-warning label-success label-info').addClass 'default'

  spanCheck = (span, pos)->
    checkid = $(span).data 'checkid'
    $(span).removeClass('default').addClass 'label-warning'
    $(span).append '<div class="pull-right"><img src="/35.gif" alt="正在验证.." /></div>'

    jqXHR = $.post "/vid/namechk/", (checkname: $('#checkname').val(), checkid: checkid), (data)->
      console.log data
      if data == '0'
        $(span).addClass 'label-success'
      else if data == '1'
        $(span).addClass 'label-important'
      else if data == '-1'
        $(span).addClass 'label-info'
    .always ->
      $(span).removeClass 'label-warning'
      $('div.pull-right', $(span)).remove()
      window.checkarr[pos] = null
      if window.checking
        _$span = $('span.label.span12.default:visible:first')[0]
        spanCheck _$span, pos if _$span
        spanCheckEnd() if $('.label-warning,.default:visible').length == 0

    window.checkarr[pos] = jqXHR

  spanCheckEnd = ->
    window.checking = false
    $('#cancel').hide()
    $('#submit').show()

  $('#submit').click ->
    return $('#cancel').click() if $('#cancel').is(':visible') || !$('#checkname').val()
    window.checking = true
    spanCheckInit()
    $('#submit').hide()
    $('#cancel').show()
    $('span.label.span12.default:visible').each (index, elem)->
      return false if index >= 10
      spanCheck this, index
    return false;

  $('#cancel').click ->
    window.checking = false
    window.checkarr.forEach (e, i)->
      e.abort() if e
    window.checkarr = []
    spanCheckInit()
    $('#submit').show()
    $('#cancel').hide()


  $('input[type="checkbox"]').on 'change', (e)->
    checked = $(this).is ':checked'
    if checked then $(".#{this.name}").show() else $(".#{this.name}").hide()

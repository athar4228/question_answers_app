bind_autocomplete_with_header_search = ->
  question_titles = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.whitespace
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: '/questions/autocomplete?query=%QUERY'
      wildcard: '%QUERY')

  $('#search').typeahead null, source: question_titles

$(document).on 'ready', ->
  bind_autocomplete_with_header_search()

$(document).on 'change', "select[data-effective-address-country]", (event) ->
  country_code = $(this).val()
  uuid = $(this).data('effective-address-country')

  url = "/addresses/subregions/#{country_code}"
  state_select = $(this).closest('form').find("select[data-effective-address-state='#{uuid}']").first()
  state_select_label = $(this).closest('.disabled').first()

  if country_code.length == 0
    state_select.prop('disabled', true)
    state_select_label.addClass('disabled')
    state_select.html('<option value="">please select a country</option>')
  else
    state_select.prop('disabled', false)
    state_select_label.removeClass('disabled')
    state_select.find('option').first().text('loading...')
    state_select.load(url)

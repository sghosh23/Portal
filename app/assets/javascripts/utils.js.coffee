# app/assets/javascript/utils.js.coffee

@amountFormat = (amount) ->
  '$ ' + Number(amount).toLocaleString()
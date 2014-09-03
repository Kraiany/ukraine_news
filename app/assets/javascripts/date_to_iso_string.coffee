unless Date::toISOString
  (->
    pad = (number) ->
      r = String(number)
      r = "0" + r  if r.length is 1
      r
    Date::toISOString = ->
      @getUTCFullYear() + "-" + pad(@getUTCMonth() + 1) + "-" + pad(@getUTCDate()) + "T" + pad(@getUTCHours()) + ":" + pad(@getUTCMinutes()) + ":" + pad(@getUTCSeconds()) + "." + String((@getUTCMilliseconds() / 1000).toFixed(3)).slice(2, 5) + "Z"
    return
  )()

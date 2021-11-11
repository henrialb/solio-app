const age = (dob) => {
  var dobdate = new Date(dob)
  var diff_ms = Date.now() - dobdate.getTime()
  var age_dt = new Date(diff_ms)

  return Math.abs(age_dt.getUTCFullYear() - 1970)
}

export { age }

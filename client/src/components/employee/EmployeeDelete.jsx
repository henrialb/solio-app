import React, { useEffect } from 'react'
import { Redirect, useParams } from 'react-router-dom'

const Api = require('./Api.js')

const EmployeeDelete = () => {

  const { id } = useParams(); // TODO: check if this is the correct way!

  useEffect(() => {
    Api.deleteEmployee(id)
    // TODO: review this code – currently not accounting for errors

      // .then(
      //   // const [error, data] = response
      //   // if(error) {
      //   //   return setErrors(data)
      //   // }
      //   <Redirect to='/patients' />
      // )
  }, [id]) // with an empty array the code will only run once
  return <Redirect to='/employees' />
}

export default EmployeeDelete

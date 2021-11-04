import React, { useState, useEffect } from 'react'
import { useParams, Redirect } from 'react-router-dom'

const Api = require('./Api.js')

const EmployeeForm = () => {
  const [employee, setEmployee] = useState({});
  const [errors, setErrors] = useState(null)
  const { id } = useParams(); // TODO: check if this is the correct way!

  useEffect(() => {
    if(id) {
      Api.getEmployee(id)
        .then(response => {
          const [error, data] = response
          if(error) {
            return setErrors(data)
          }
          setEmployee(data)
        })
    }
  }, [id]) // with an empty array the code will only run once

  // const [name, setName] = useState('');

  // const handleChange = (event) => {
  //   setFullName(event.target.value);
  //   // setName(event.target.value);
  // }

  const handleChange = (event) => {
    let value = event.target.value;
    let name = event.target.name;

    setEmployee((prevalue) => {
      return {
        ...prevalue, // TODO: wtf is this? Spread Operator
        [name]: value
      }
    })
  }

  const handleSubmit = (event) => {
    event.preventDefault();

    // const emailInput = event.target.email; // accessing directly
    // const ageInput = event.target.elements.age; // accessing via `form.elements`

    // console.log(emailInput.value); // output: 'foo@bar.com'
    // console.log(ageInput.value); // output: '18'

    // console.log(employee.fullName)

    // setEmployee({
    //   full_name: employee.fullName
    // })

    Api.saveEmployee(employee, employee.id)
      .then(response => {
        const [error, data] = response
        if (error) {
          setErrors(data)
        } else {
          <Redirect to='/employees' /> // TODO: Redirect (and handling errors) not working!
        }
      })
  }

  if (errors) {
    return errors
  } else {
    return (
      <div className="container">
        <div className="row">
          <div className="col">
            <h3>Edit employee</h3>

            {/* TODO: handle errors correctly */}
            {errors?.length > 0 &&
              <div>
                {errors.map((error, index) =>
                  <div className="alert-danger" key={index}>
                    {error}
                  </div>
                )}
              </div>
            }

            <form onSubmit={handleSubmit}>
              <div className="input-group">
                <label htmlFor="full_name" className="form-label">Full name</label>
                <input type="text" name="full_name" id="full_name" value={employee.full_name} placeholder="Enter full name" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="name" className="form-label">Name</label>
                <input type="text" name="name" id="name" value={employee.name} placeholder="Enter name" onChange={handleChange} className="form-control" />
              </div>
              {/* <div className="input-group">
                <label htmlFor="sex" className="form-label">Sex</label>
                <select name="sex" id="sex" value={employee.sex} onChange={this.setSex} className="form-control" >
                  <option value="male">male</option>
                  <option value="female">female</option>
                </select>
              </div>
              <div className="input-group">
                <label htmlFor="dob" className="form-label">Date of birth</label>
                <input type="date" name="dob" id="dob" value={employee.dob} placeholder="Enter date of birth" onChange={this.setDob} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="citizenNo" className="form-label">Citizen number</label>
                <input type="text" name="citizenNo" id="citizenNo" value={employee.citizenNo} placeholder="Enter citizen number" onChange={this.setCitizenNo} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="nifNo" className="form-label">Nif number</label>
                <input type="text" name="nifNo" id="nifNo" value={employee.nifNo} placeholder="Enter nif number" onChange={this.setNifNo} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="healthNo" className="form-label">Health number</label>
                <input type="text" name="healthNo" id="healthNo" value={employee.healthNo} placeholder="Enter health number" onChange={this.setHealthNo} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="socialSecurityNo" className="form-label">Social security number</label>
                <input type="text" name="socialSecurityNo" id="socialSecurityNo" value={employee.socialSecurityNo} placeholder="Enter social security number" onChange={this.setSocialSecurityNo} className="form-control" />
              </div>
              {/* TODO: fix isActive, info is not being sent to db
              <div className="input-group">
                <label htmlFor="isActive" className="form-label">Is active?</label>
                <select name="isActive" id="isActive" value={employee.isActive} onChange={this.setIsActive} className="form-control" >
                  <option value="1">true</option>
                  <option value="0">false</option>
                </select>
              </div> */ }
              <button className="btn btn-success">Submit</button>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

export default EmployeeForm

import React, { useState, useEffect } from 'react'
import { useParams, useHistory } from 'react-router-dom'
import { client } from '../../../Api'

const ExpenseForm = () => {
  const history = useHistory()
  const [expense, setExpense] = useState({})
  const [error, setError] = useState(null)
  const { id } = useParams()

  useEffect(() => {
    if (id) {
      client.get(`/patient_expenses/${id}`)
        .then((response) => {
          setExpense(response.data)
        }).catch(error => {
          setError(error)
        })
    }
  }, [id])

  const handleChange = (event) => {
    setExpense((prevalue) => {
      return {
        ...prevalue,
        [event.target.name]: event.target.value
      }
    })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    client.put(`/patient_expenses/${id}`, expense)
      .then((response) => {
        setExpense(response.data)
        alert("Expense edited!") // TODO: change this
      })

    // TODO: with useHistory, changes are not reflected in new path
    history.push('/despesas')
  }

  if (error) {
    return (
      <>
        <h1>{error.message}</h1>
        <p>{JSON.stringify(error, null, 2)}</p>
      </>
    )
  } else {
    return (
      <div className="container">
        <div className="row">
          <div className="col">
            <form onSubmit={handleSubmit}>
              {/* TODO: change to patient name */}
              <div className="input-group">
                <label htmlFor="patientFileId" className="form-label">Patient File Id</label>
                <input type="text" name="patientFileId" id="patientFileId" value={expense.patientFileId} placeholder="Enter patient file id" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="amount" className="form-label">Amount</label>
                <input type="number" name="amount" id="amount" value={expense.amount} placeholder="Enter amount" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="date" className="form-label">Date</label>
                <input type="date" name="date" id="date" value={expense.date} placeholder="Enter date" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="description" className="form-label">Description</label>
                <input type="text" name="description" id="description" value={expense.description} placeholder="Enter description" onChange={handleChange} className="form-control" />
              </div>
              <div className="input-group">
                <label htmlFor="note" className="form-label">Note</label>
                <input type="text" name="note" id="note" value={expense.note} placeholder="Enter note" onChange={handleChange} className="form-control" />
              </div>
              <button className="btn btn-success">Submit</button>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

export default ExpenseForm

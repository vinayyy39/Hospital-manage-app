<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Patient Registration — MediCore HMS</title>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>

:root{
  --teal:#0F6E56;
  --teal-light:#E1F5EE;
  --text-dark:#1a2332;
  --text-muted:#64748b;
  --border:#e2e8f0;
  --white:#ffffff;
  --bg:#f8fbff;
}

*{
  margin:0;
  padding:0;
  box-sizing:border-box;
}

body{
  font-family:'DM Sans',sans-serif;
  background:var(--bg);
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:24px;
}

.register-wrap{
  display:grid;
  grid-template-columns:1fr 1fr;
  max-width:1000px;
  width:100%;
  background:white;
  border-radius:24px;
  overflow:hidden;
  border:1px solid var(--border);
  box-shadow:0 24px 60px rgba(0,0,0,0.08);
}

.panel-left{
  background:#0a3d2d;
  padding:56px 48px;
  color:white;
  display:flex;
  flex-direction:column;
  justify-content:space-between;
}

.panel-logo{
  font-size:28px;
  font-weight:600;
  font-family:'Playfair Display',serif;
}

.panel-logo span{
  color:#5DCAA5;
}

.panel-content h2{
  font-size:34px;
  line-height:1.3;
  margin-bottom:16px;
  font-family:'Playfair Display',serif;
}

.panel-content p{
  color:rgba(255,255,255,0.7);
  line-height:1.7;
}

.panel-right{
  padding:50px 40px;
}

.form-header{
  margin-bottom:28px;
}

.form-tag{
  display:inline-block;
  background:var(--teal-light);
  color:var(--teal);
  padding:6px 14px;
  border-radius:20px;
  font-size:11px;
  font-weight:600;
  margin-bottom:14px;
}

.form-header h1{
  font-size:30px;
  margin-bottom:8px;
  color:var(--text-dark);
  font-family:'Playfair Display',serif;
}

.form-header p{
  color:var(--text-muted);
  font-size:14px;
}

.form-group{
  margin-bottom:18px;
}

label{
  display:block;
  margin-bottom:8px;
  font-size:13px;
  font-weight:500;
  color:var(--text-dark);
}

.input-wrap{
  position:relative;
}

.input-icon{
  position:absolute;
  left:14px;
  top:50%;
  transform:translateY(-50%);
  color:#94a3b8;
}

.input-icon svg{
  width:16px;
  height:16px;
}

input{
  width:100%;
  height:46px;
  border:1.5px solid var(--border);
  border-radius:10px;
  padding:0 16px 0 42px;
  font-size:15px;
  background:var(--bg);
  outline:none;
  transition:0.2s;
}

input:focus{
  border-color:var(--teal);
  background:white;
  box-shadow:0 0 0 4px rgba(15,110,86,0.08);
}

.btn-register{
  width:100%;
  height:48px;
  background:var(--teal);
  color:white;
  border:none;
  border-radius:10px;
  font-size:15px;
  font-weight:500;
  cursor:pointer;
  margin-top:12px;
  transition:0.2s;
}

.btn-register:hover{
  background:#084b3c;
}

.form-footer{
  text-align:center;
  margin-top:18px;
  font-size:13px;
  color:var(--text-muted);
}

.form-footer a{
  color:var(--teal);
  text-decoration:none;
}

@media(max-width:768px){

  .register-wrap{
    grid-template-columns:1fr;
  }

  .panel-left{
    display:none;
  }

  .panel-right{
    padding:35px 24px;
  }

}

</style>
</head>

<body>

<div class="register-wrap">

  <!-- LEFT -->

  <div class="panel-left">

    <div class="panel-logo">
      Medi<span>Core</span>
    </div>

    <div class="panel-content">

      <h2>
        Create Secure<br>
        Patient Account
      </h2>

      <p>
        Register patients securely and manage
        hospital appointments with ease.
      </p>

    </div>

  </div>

  <!-- RIGHT -->

  <div class="panel-right">

    <div class="form-header">

      <span class="form-tag">Patient Registration</span>

      <h1>Create Account</h1>

      <p>
        Register to access the hospital management system
      </p>

    </div>

    <form action="AdminRegister.jsp" method="post">

      <!-- ID -->

      <div class="form-group">

        <label>Patient ID</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="8" cy="5" r="3"/>
              <path d="M2 14c0-3.3 2.7-6 6-6s6 2.7 6 6"/>
            </svg>
          </div>

          <input type="number"
                 name="id"
                 placeholder="Enter patient ID"
                 required>

        </div>

      </div>

      <!-- NAME -->

      <div class="form-group">

        <label>Full Name</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="8" cy="5" r="3"/>
              <path d="M2 14c0-3.3 2.7-6 6-6s6 2.7 6 6"/>
            </svg>
          </div>

          <input type="text"
                 name="name"
                 placeholder="Enter full name"
                 required>

        </div>

      </div>

      <!-- AGE -->

      <div class="form-group">

        <label>Age</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="8" cy="8" r="6"/>
            </svg>
          </div>

          <input type="number"
                 name="age"
                 placeholder="Enter age"
                 required>

        </div>

      </div>

      <!-- GENDER -->

      <div class="form-group">

        <label>Gender</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M8 2v12M2 8h12"/>
            </svg>
          </div>

          <input type="text"
                 name="gender"
                 placeholder="Male / Female"
                 required>

        </div>

      </div>

      <!-- PHONE -->

      <div class="form-group">

        <label>Phone Number</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <rect x="4" y="2" width="8" height="12" rx="1"/>
            </svg>
          </div>

          <input type="number"
                 name="phone"
                 placeholder="Enter phone number"
                 required>

        </div>

      </div>

      <!-- ADDRESS -->

      <div class="form-group">

        <label>Address</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M8 14s4-4.5 4-8A4 4 0 1 0 4 6c0 3.5 4 8 4 8z"/>
            </svg>
          </div>

          <input type="text"
                 name="address"
                 placeholder="Enter address"
                 required>

        </div>

      </div>

      <!-- DOCTOR ID -->

      <div class="form-group">

        <label>Doctor ID</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <circle cx="8" cy="5" r="3"/>
              <path d="M2 14c0-3.3 2.7-6 6-6s6 2.7 6 6"/>
            </svg>
          </div>

          <input type="number"
                 name="doctor_id"
                 placeholder="Enter doctor ID"
                 required>

        </div>

      </div>

      <!-- EMAIL -->

      <div class="form-group">

        <label>Email Address</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M2 4l6 5 6-5"/>
              <rect x="2" y="3" width="12" height="10" rx="2"/>
            </svg>
          </div>

          <input type="email"
                 name="email"
                 placeholder="Enter email"
                 required>

        </div>

      </div>

      <!-- PASSWORD -->

      <div class="form-group">

        <label>Password</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <rect x="3" y="7" width="10" height="8" rx="1.5"/>
              <path d="M5 7V5a3 3 0 0 1 6 0v2"/>
            </svg>
          </div>

          <input type="password"
                 name="password"
                 placeholder="Create password"
                 required>

        </div>

      </div>

      <!-- CONFIRM PASSWORD -->

      <div class="form-group">

        <label>Confirm Password</label>

        <div class="input-wrap">

          <div class="input-icon">
            <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.5">
              <rect x="3" y="7" width="10" height="8" rx="1.5"/>
              <path d="M5 7V5a3 3 0 0 1 6 0v2"/>
            </svg>
          </div>

          <input type="password"
                 name="confirm_password"
                 placeholder="Confirm password"
                 required>

        </div>

      </div>

      <!-- BUTTON -->

      <button type="submit" class="btn-register">
        Create Account
      </button>

    </form>

    <div class="form-footer">

      Already have an account?
      <a href="admin.html">Sign In</a>

    </div>

  </div>

</div>

</body>
</html>
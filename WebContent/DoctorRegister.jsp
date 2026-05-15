<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Doctor Registration — MediCore HMS</title>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
:root{
  --green:#0F766E;
  --green-dark:#115E59;
  --green-light:#E6FFFB;
  --text:#1a2332;
  --muted:#64748b;
  --border:#e2e8f0;
  --bg:#f8fbff;
  --white:#fff;
}

*{
  margin:0;
  padding:0;
  box-sizing:border-box;
  font-family:'DM Sans', sans-serif;
}

body{
  min-height:100vh;
  display:flex;
  justify-content:center;
  align-items:center;
  background:var(--bg);
  padding:20px;
}

/* background glow */
body::before{
  content:'';
  position:fixed;
  inset:0;
  background:
    radial-gradient(circle at 20% 30%, rgba(15,118,110,0.10), transparent 45%),
    radial-gradient(circle at 80% 70%, rgba(17,94,89,0.08), transparent 45%);
}

/* card */
.container{
  width:100%;
  max-width:850px;
  display:grid;
  grid-template-columns:1fr 1fr;
  background:white;
  border-radius:20px;
  overflow:hidden;
  box-shadow:0 20px 60px rgba(0,0,0,0.10);
  position:relative;
  z-index:1;
}

/* LEFT */
.left{
  background:#0B3B36;
  padding:50px 40px;
  color:white;
  display:flex;
  flex-direction:column;
  justify-content:space-between;
}

.logo{
  display:flex;
  align-items:center;
  gap:10px;
  font-size:22px;
  font-family:'Playfair Display', serif;
}

.logo span{
  color:#5EEAD4;
}

.left h2{
  font-size:32px;
  margin-top:40px;
  font-family:'Playfair Display', serif;
  line-height:1.3;
}

.left p{
  font-size:14px;
  color:rgba(255,255,255,0.7);
  margin-top:15px;
  line-height:1.6;
}

/* RIGHT */
.right{
  padding:45px;
}

.tag{
  display:inline-block;
  padding:6px 12px;
  background:var(--green-light);
  color:var(--green);
  font-size:11px;
  font-weight:600;
  border-radius:20px;
  margin-bottom:15px;
}

h1{
  font-family:'Playfair Display', serif;
  font-size:28px;
  margin-bottom:5px;
  color:var(--text);
}

.subtitle{
  color:var(--muted);
  font-size:13px;
  margin-bottom:25px;
}

form input{
  width:100%;
  padding:12px 14px;
  margin-bottom:14px;
  border:1.5px solid var(--border);
  border-radius:10px;
  background:#f8fafc;
  font-size:14px;
  outline:none;
  transition:0.2s;
}

form input:focus{
  border-color:var(--green);
  background:white;
  box-shadow:0 0 0 4px rgba(15,118,110,0.08);
}

button{
  width:100%;
  padding:12px;
  background:var(--green);
  color:white;
  border:none;
  border-radius:10px;
  font-size:15px;
  cursor:pointer;
  transition:0.2s;
  font-weight:500;
}

button:hover{
  background:var(--green-dark);
  transform:translateY(-1px);
}

.footer{
  text-align:center;
  margin-top:15px;
  font-size:12px;
}

.footer a{
  color:var(--green);
  text-decoration:none;
  font-weight:500;
}

@media(max-width:768px){
  .container{
    grid-template-columns:1fr;
  }

  .left{
    display:none;
  }
}
</style>
</head>

<body>

<div class="container">

  <!-- LEFT PANEL -->
  <div class="left">

    <div class="logo">
      Medi<span>Core</span>
    </div>

    <div>
      <h2>Doctor Registration<br>Portal</h2>
      <p>
        Register new doctors into MediCore HMS system.
        Manage hospital staff efficiently with secure records and fast access.
      </p>
    </div>

  </div>

  <!-- RIGHT PANEL -->
  <div class="right">

    <div class="tag">Doctor Module</div>

    <h1>Register Doctor</h1>
    <div class="subtitle">Fill details to add new doctor</div>

    <form action="SaveDoctor.jsp" method="post">

      <input type="text" name="name" placeholder="Doctor Full Name" required>

      <input type="text" name="specialization" placeholder="Specialization (e.g. Cardiology)" required>

      <input type="text" name="phone" placeholder="Phone Number" required>

      <input type="email" name="email" placeholder="Email Address" required>

      <input type="password" name="pwd" placeholder="Create Password" required>

      <button type="submit">Register Doctor</button>

    </form>

    <div class="footer">
      <a href="doctor.html">← Back to Login</a>
    </div>

  </div>

</div>

</body>
</html>
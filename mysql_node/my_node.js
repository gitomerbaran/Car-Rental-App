const express = require('express');
const mysql = require('mysql');

const app = express();

// Bağlantı bilgileri
const connection = mysql.createConnection({
  host: '172.20.10.8',
  user: 'root',
  password: '3Florotoluen.',
  database: 'mydb',
  connectTimeout: 10000
});

// Bağlanma
connection.connect((err) => {
  if (err) {
    console.error('Bağlantı hatası:', err.stack);
    return;
  }
  
  console.log('MySQL sunucusuna bağlandı. Bağlantı kimliği:', connection.threadId);
});

// Kullanıcı girişi (login) endpoint'i
app.post('/login', (req, res) => {
  const { tc, password } = req.body;

  // Kullanıcıyı veritabanında kontrol et
  connection.query('SELECT * FROM users WHERE tc = ? AND password = ?', [tc, password], (error, results, fields) => {
    if (error) {
      console.error('Sorgu hatası:', error);
      res.status(500).json({ message: 'Internal server error' });
      return;
    }

    if (results.length > 0) {
      // Kullanıcı bulundu, giriş başarılı
      res.status(200).json({ message: 'Login successful' });
    } else {
      // Kullanıcı bulunamadı, giriş başarısız
      res.status(401).json({ message: 'Invalid username or password' });
    }
  });
});

app.post('/register',(req,res)=>{
const {tc,ad,soyad,mail,password}=req.body;
const registerSQL='CALL ADDCUSTOMER(?,?,?,?,?)';
connection.query(registerSQL,[tc,ad,soyad,mail,password],(err,result)=>{
  if(err){
    console.error(err);
    return res.status(500).send({message: 'Hatalı Kayit'});
  }
  res.send({message:'basarili'});
  
});


});

// Örnek bir endpoint
app.get('/data', (req, res) => {
  connection.query('SELECT * FROM mytable', (error, results, fields) => {
    if (error) {
      console.error('Sorgu hatası:', error);
      res.status(500).json({ message: 'Internal server error' });
      return;
    }
    console.log('Sonuçlar:', results);
    res.json(results); // Sonuçları JSON olarak döndür
  }); 
});

app.listen(port, () => {
  console.log('API çalışıyor...');
});

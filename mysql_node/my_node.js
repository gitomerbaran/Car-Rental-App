const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3001;

app.use(express.json());

const connection = mysql.createConnection({
  host: '172.20.10.8',
  user: 'root',
  password: '3Florotoluen.',
  database: 'mydb',
  connectTimeout: 10000
});

connection.connect((err) => {
  if (err) {
    console.error('Bağlantı hatası:', err.stack);
    return;
  }
  
  console.log('MySQL sunucusuna bağlandı. Bağlantı kimliği:', connection.threadId);
});



app.post('/login', async (req, res) => {
  const { mail, password } = req.body;
  connection.query('CALL LOGIN(?,?)', [mail, password], (error, results, fields) => {
    if(error){
      console.error(error);
      return res.status(500).send({ message: 'Hatalı Giriş' });
    } else {
      console.log(results); // Veritabanından dönen sonuçları kontrol etmek için
      if(results[0][0].STATU == 'YES'){ // results[0][0] kullanılarak işlem sonucu alınıyor
        console.log(results[0][0]); 
        const tcKimlikNo = results[0][0].TC; // TC_KIMLIK_NO değişkeni değil, TC
        return res.status(200).send({ tc: tcKimlikNo }); // tc yerine tcKimlikNo
      } else {
        console.log("Çalışmadım");
        // Değişiklik burada: 300 statü kodu döndürülüyor
        return res.status(300).send({ message: 'başarılı' });
      }
    }
  });
});



/* app.post('/login', async (req, res) => {
  const { mail, password } = req.body;
  connection.query('SELECT * FROM LOGINS', (error, results, fields) => {
    if(error){
      console.error(error);
      return res.status(500).send({ message: 'Hatalı Giriş' });
    } else {
      if(results[0].STATU == 'YES'){
        console.log(results[0]); 
        return res.status(200).send({});
      } else {
        console.log("çalışmadım");
        // Değişiklik burada: 300 statü kodu döndürülüyor
        return res.status(300).send({ message: 'başarılı' });
      }
    }
  });
}); */



app.post('/register', (req, res) => {
  const { tc, ad, soyad, mail, password } = req.body;
  
  connection.query('CALL ADDCUSTOMER(?, ?, ?, ?, ?)', [tc, ad, soyad, mail, password], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).send({ message: 'Hatalı Kayıt' });
    } else {
      res.send({ message: 'Başarılı' });
    }
  });
});

app.get('/data', (req, res) => {
  connection.query('SELECT * FROM mytable', (error, results, fields) => {
    if (error) {
      console.error('Sorgu hatası:', error);
      res.status(500).json({ message: 'İç sunucu hatası' });
      return;
    }
    console.log('Sonuçlar:', results);
    res.json(results);
  });
});

app.listen(port, () => {
  console.log(`API ${port} portunda çalışıyor...`);
});

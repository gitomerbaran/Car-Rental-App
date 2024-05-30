const mysql = require('mysql');

// Bağlantı bilgileri
const connection = mysql.createConnection({
  host: '172.20.10.8',
  user: 'root',
  password: '3Florotoluen.',
  database: 'mydb',
  connectTimeout: 200000
});

// Bağlanma
connection.connect((err) => {
  if (err) {
    console.error('Bağlantı hatası:', err.stack);
    return;
  }
  
  console.log('MySQL sunucusuna bağlandı. Bağlantı kimliği:', connection.threadId);

     connection.query('CALL SELECTORBRND(34);', (error, results, fields) => {
    if (error) {
      console.error('Sorgu hatası:', error);
      return;
    }
    console.log('Sonuçlar:', results);

    // Bağlantıyı kapatma
    connection.end((err) => {
      if (err) {
        console.error('Bağlantı kapatma hatası:', err);
        return;
      }
      console.log('Bağlantı başarıyla kapatıldı.');
    });
  }); 
});
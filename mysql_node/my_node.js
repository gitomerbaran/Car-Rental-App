const express = require('express');
const mysql = require('mysql');

const app = express();

// Bağlantı bilgileri
const connection = mysql.createConnection({
  host: '**********',
  user: '******',
  password: '*******.',
  database: '********',
});

// Bağlanma
connection.connect((err) => {
  if (err) {
    console.error('Bağlantı hatası:', err.stack);
    return;
  }
  
  console.log('MySQL sunucusuna bağlandı. Bağlantı kimliği:', connection.threadId);


/* connection.query('SELECT * FROM tablo', (error, results, fields) => {
  if (error) {
    console.error('Sorgu hatası:', error);
    return;
  }
  console.log('Sonuçlar:', results);
}); */

// Bağlantıyı kapatma
connection.end();

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


 
 app.get('/getAllModels', (req, res) => {

    
    console.log('Connected to the database.');

    connection.query('CALL ALLMODELS()', (error, results, fields) => {
      if (error) {
        console.error('Error executing the query:', error.stack);
        res.status(500).send('Error executing the query');
        connection.end();
        return;
      }
       else{
      const models = results[0].map(row => row.MODEL);
      res.json(models);
       }
    });
  }); 
  //
  app.get('/getAllTypes', (req, res) => {

    
    console.log('Connected to the database.');

    connection.query('CALL ALLTYPES()', (error, results, fields) => {
      if (error) {
        console.error('Error executing the query:', error.stack);
        res.status(500).send('Error executing the query');
        connection.end();
        return;
      }
       else{
      const types = results[0].map(row => row.ARACTUR);
      res.json(types);
       }
    });
  }); 
  //
  app.get('/getAllBrands', (req, res) => {

    
    console.log('Connected to the database.');

    connection.query('CALL ALLBRANDS()', (error, results, fields) => {
      if (error) {
        console.error('Error executing the query:', error.stack);
        res.status(500).send('Error executing the query');
        connection.end();
        return;
      }
       else{
      const brands = results[0].map(row => row.MARKA);
      res.json(brands);
       }
    });
  }); 
  app.get('/getAllCities', (req, res) => {

    
    console.log('Connected to the database.');

    connection.query('CALL ALLCITY()', (error, results, fields) => {
      if (error) {
        console.error('Error executing the query:', error.stack);
        res.status(500).send('Error executing the query');
        connection.end();
        return;
      }
       else{
      const cities = results[0].map(row => row.ILALIS);
      res.json(cities);
       }
    });
  }); 

  app.post('/getRentCarList', async (req, res) => {
    const { city, brand, type,model } = req.body;
    connection.query('CALL SELECTORVHCL(?,?,?,?)',[city,brand,type,model], (error, results, fields) => {
        
      if(error){
        console.error(error);
        return res.status(500).send({ message: 'Hatalı Sorgu' });
      } 
        // Sonuçlar dizisinin boş olup olmadığını kontrol edelim
        console.log(results);
        const cars = results;
      res.json(cars);
        
        
      
    });
  });
 
  app.post('/sendRentCar', async (req, res) => {
    const { PLAKA, ILDONUS, ALISTAR,DONUSTAR,MUSTERITC } = req.body;
    connection.query('CALL BINDCUSTOMER(?,?,?,?,?)',[PLAKA,ILDONUS,ALISTAR,DONUSTAR,MUSTERITC], (error, results, fields) => {
        
      if(error){
        console.error(error);
        return res.status(500).send({ message: 'Hatalı Sorgu' });
      } 
        // Sonuçlar dizisinin boş olup olmadığını kontrol edelim
        else{
          console.log(results);
          const car = results;
          res.json(car);
        }
        
        
        
      
    });
  });

  app.post('/addCarMng', async (req, res) => {
    const { PLAKA,ILALIS,MODEL,ARACTUR,KAPIADET,ADET,RENK,VITESTUR,YAKIT,KM,YIL,FIYAT,MARKA } = req.body;
    connection.query('CALL ADDVEHICLE(?,?,?,?,?,?,?,?,?,?,?,?,?)',[PLAKA,ILALIS,MODEL,ARACTUR,KAPIADET,ADET,RENK,VITESTUR,YAKIT,KM,YIL,FIYAT,MARKA], (error, results, fields) => {
        
      if(error){
        console.error(error);
        return res.status(500).send({ message: 'Hatalı Sorgu' });
      } 
        // Sonuçlar dizisinin boş olup olmadığını kontrol edelim
        else{
          console.log(results);
          const car = results;
          res.json(car);
        }
        
        
        
      
    });
  });
 
  app.post('/dropCustomer', async (req, res) => {
    const {PLAKA,MUSTERITC} = req.body;
    connection.query('CALL DROPCUSTOMER(?,?)',[PLAKA,MUSTERITC], (error, results, fields) => {
        
      if(error){
        console.error(error);
        return res.status(500).send({ message: 'Hatalı Sorgu' });
      } 
        // Sonuçlar dizisinin boş olup olmadığını kontrol edelim
        else{
          console.log(results);
          const car = results;
          res.json(car);
        }
        
        
        
      
    });
  });

  app.get('/getCustomers', (req, res) => {
    connection.query('SELECT PLAKA,MUSTERITC FROM PLAKMUS WHERE MUSTERITC IS NOT NULL', (error, results, fields) => {
        if (error) {
            console.error('Error executing the query:', error.stack);
            res.status(500).send('Error executing the query');
            connection.end();
            return;
        }
        console.log(results);
       
        res.json(results);
    });
});


  app.post('/login', async (req, res) => {
    const { mail, password } = req.body;
    connection.query('CALL LOGIN(?,?)',[mail,password], (error, results, fields) => {
        
      if(error){
        console.error(error);
        return res.status(500).send({ message: 'Hatalı Giriş' });
      } else {
        // Sonuçlar dizisinin boş olup olmadığını kontrol edelim
        if(results.length> 0 && results[0][0].STATU === 'YES'){
          console.log(results[0]); 
          const tcKimlikNo = results[0][0].TC; // TC_KIMLIK_NO değişkeni değil, TC
        return res.status(200).send({ tc: tcKimlikNo }); // tc yerine tcKimlikNo
        
        } else {
          console.log(results);
          console.log("çalışmadım");
          // Değişiklik burada: 300 statü kodu döndürülüyor
          return res.status(300).send({ message: 'başarılı' });
        }
      }
    });
  });
  



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



app.listen(port, () => {
  console.log(`API ${port} portunda çalışıyor...`);
});


/* package dbase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Scanner;

public class Main {
	
	public static void main(String[] args) {
		String city;
		String brand;
		String type;
		String model;
		String plate;
		String destination;
		String taketime;
		String releasetime;
		String color;
		String transmitter;
		String fuel;
		String km;
		int veid;
		int moid;
		int brid;
		int year;
		int price;
		int doors;
		int piece;
		long tc;
		try {
            Connection myCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","3Florotoluen.");
            if (myCon != null) {
                System.out.println("Connection to the database is successful.");
            } else {
                System.out.println("Failed to connect to the database.");
            }
            System.out.println("please input variables");
            Scanner scanner = new Scanner(System.in);
            city = scanner.next();
            brand = scanner.next();
            type = scanner.next();
            model = scanner.next();
            scanner.close();
            SelectorVehicle selectorv = new SelectorVehicle();
            selectorv.chooser(myCon,city,brand,type,model);
            plate = scanner.next();
            destination = scanner.next();
            taketime = scanner.next();
            releasetime = scanner.next();
            tc = scanner.nextLong();
            scanner.close();
            Binder binders = new Binder();
            binders.binder(myCon,plate,destination,taketime,releasetime,tc);
            plate = scanner.next();
            city = scanner.next();
            model = scanner.next();
            type = scanner.next();
            doors = scanner.nextInt();
            piece = scanner.nextInt();
            color = scanner.next();
            transmitter = scanner.next();
            fuel = scanner.next();
            km = scanner.next();
            year = scanner.nextInt();
            price = scanner.nextInt();
            brand = scanner.next();
            scanner.close();
            AddVehicle addvehicle = new AddVehicle();
            addvehicle.addvehicles(myCon,plate,city,model,type,doors,piece,
            		color,transmitter,fuel,km,year,price,brand);
            plate = scanner.next();
            veid = scanner.nextInt();
            moid = scanner.nextInt();
            brid = scanner.nextInt();
            scanner.close();
            DropVehicle dropvehicle = new DropVehicle();
            dropvehicle.dropvehicles(myCon,plate,veid,moid,brid);
            myCon.close();
        } catch(Exception e) {
            e.printStackTrace();
        }

	}
}
package dbase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SelectorVehicle {
	int a;
	public void chooser(Connection myCon, String city,String brand,String type,String model) {
		if(city.equalsIgnoreCase("İSTANBUL")) {
			a = 34;
		}
		if(city.equalsIgnoreCase("ANKARA")) {
			a = 06;
		}
		if(city.equalsIgnoreCase("İZMİR")) {
			a = 35;
		}
		if(city.equalsIgnoreCase("ANTALYA")) {
			a = 07;
		}
		if(city.equalsIgnoreCase("SAMSUN")) {
			a = 55;
		}
		if(city.equalsIgnoreCase("ERZURUM")) {
			a = 25;
		}
		if(city.equalsIgnoreCase("DİYARBAKİR")) {
			a = 21;
		}
		selector(myCon ,a, brand, type, model);
	}
	
	public void selector(Object myCon,int a,String brand,String type,String model) {
		try {
            String sql = "CALL SELECTORVHCL(?,?,?,?)";
            PreparedStatement myStmt = ((Connection) myCon).prepareStatement(sql);
            
            myStmt.setInt(1, a);
            myStmt.setString(2, brand);
            myStmt.setString(3, type);
            myStmt.setString(4, model);
            
            ResultSet myRes = myStmt.executeQuery();
            while(myRes.next()) {
                System.out.println(myRes.getString("PLAKA")+" "
                		+(myRes.getString("MARKA")+" "
                        +(myRes.getString("ARACTUR")+" "
                		+(myRes.getString("MODEL")+" "
                        +(myRes.getString("RENK")+" "
                		+(myRes.getString("VITESTUR")+" "
                        +(myRes.getString("YAKIT")+" "
                		+(myRes.getInt("KAPIADET")+" "
                        +(myRes.getString("KM")+" "
                		+(myRes.getInt("YIL")+" "
                        +(myRes.getInt("FIYAT"))))))))))));
            }
            
            myRes.close();
            myStmt.close();
            ((Connection) myCon).close();
        } catch(Exception e) {
            e.printStackTrace();
        }

	}
} */
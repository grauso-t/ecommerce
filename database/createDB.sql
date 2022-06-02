DROP DATABASE ecommerce;
CREATE DATABASE ecommerce;

USE ecommerce;

CREATE TABLE Utente (
	ID_Utente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    Data_Nascita DATE NOT NULL,
    Email VARCHAR(30) UNIQUE NOT NULL,
    Accesso VARCHAR(40) NOT NULL,
    Telefono CHAR(10) NOT NULL,
    Citta VARCHAR(30) NOT NULL,
    Provincia CHAR(2) NOT NULL,
    Codice_Postale CHAR(5) NOT NULL,
    Indirizzo VARCHAR(30) NOT NULL,
    Data_Registrazione DATE NOT NULL,
    Stato BOOLEAN DEFAULT TRUE,
    Amministratore BOOLEAN DEFAULT FALSE
);

CREATE TABLE Carrello (
	ID_Carrello INT AUTO_INCREMENT PRIMARY KEY,
    Utente INT REFERENCES Utente(ID_Utente),
    Totale DOUBLE NOT NULL,
    Numero_Prodotti INT NOT NULL DEFAULT 0
);

CREATE TABLE Prodotto (
	ID_Prodotto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(30) NOT NULL,
    Descrizione VARCHAR(255) NOT NULL,
    Prezzo DOUBLE NOT NULL,
    Quantità_Disponibile INT NOT NULL DEFAULT 0,
    Sconto INT NOT NULL DEFAULT 0,
    Immagine VARCHAR(255) NOT NULL,
    Categoria VARCHAR(10) NOT NULL
);

CREATE TABLE Carrello_Prodotto (
	ID_Carrello_Prodotto INT AUTO_INCREMENT PRIMARY KEY,
    Prodotto INT REFERENCES Prodotto(ID_Prodotto),
    Carrello INT REFERENCES Carrello(ID_Carrello),
    Quantità INT NOT NULL DEFAULT 1
);

CREATE TABLE Ordine (
	ID_Ordine INT AUTO_INCREMENT PRIMARY KEY,
    Utente INT REFERENCES Utente(ID_Utente),
    Costi_Spedizione DOUBLE,
    Totale DOUBLE NOT NULL
);

CREATE TABLE Ordine_Prodotto (
	ID_Ordine_Prodotto INT AUTO_INCREMENT PRIMARY KEY,
	Ordine INT REFERENCES Ordine(ID_Ordine),
    Prodotto INT REFERENCES Prodotto(ID_Prodotto)
);

CREATE TABLE Spedizione (
	ID_Spedizione INT AUTO_INCREMENT PRIMARY KEY,
    Data_Partenza DATE NOT NULL,
    Data_Arrivo DATE NOT NULL,
    Ordine INT REFERENCES Ordine(ID_Ordine)
);

CREATE TABLE Pagamento (
	ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    Ordine INT REFERENCES Ordine(ID_Ordine),
    Data_Pagamento DATE NOT NULL,
    Stato BOOLEAN DEFAULT 0 NOT NULL
);

CREATE TABLE Fattura (
	ID_Fattura INT AUTO_INCREMENT PRIMARY KEY,
	ID_Pagamento INT REFERENCES Pagamento(ID_Pagamento),
	Città VARCHAR(30) NOT NULL,
    Provincia CHAR(2) NOT NULL,
    Codice_Postale CHAR(5) NOT NULL,
    Indirizzo VARCHAR(10) NOT NULL
);

INSERT INTO Utente (Nome, Cognome, Data_Nascita, Email, Accesso, Telefono, Citta, Provincia, Codice_Postale, Indirizzo, Data_Registrazione, Stato, Amministratore) VALUES("Teodoro","Grauso","2001-10-12","teo@ecommerce.com","5cec175b165e3d5e62c9e13ce848ef6feac81bff","1234567890","Fisciano","SA","84040","Via, 1","2022-01-01",TRUE,TRUE);
INSERT INTO Utente (Nome, Cognome, Data_Nascita, Email, Accesso, Telefono, Citta, Provincia, Codice_Postale, Indirizzo, Data_Registrazione, Stato, Amministratore) VALUES("Michele","Spinelli","2000-07-06","mike@ecommerce.com","5cec175b165e3d5e62c9e13ce848ef6feac81bff","1234567890","Fisciano","SA","84040","Via, 2","2022-01-01",TRUE,TRUE);
INSERT INTO Utente (Nome, Cognome, Data_Nascita, Email, Accesso, Telefono, Citta, Provincia, Codice_Postale, Indirizzo, Data_Registrazione, Stato, Amministratore) VALUES("Junhuang","Chen","2001-02-11","junhuang@ecommerce.com","5cec175b165e3d5e62c9e13ce848ef6feac81bff","1234567890","Fisciano","SA","84040","Via, 3","2022-01-01",TRUE,TRUE);
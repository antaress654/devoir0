#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------

#------------------------------------------------------------
#        Creation de la base de donnees
#------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `centre_de_formation`;
USE `centre_de_formation`

#------------------------------------------------------------
#        Creation de la `table` Edutiant
#------------------------------------------------------------

CREATE TABLE NOT EXISTS `Edutiant`(
    `NumCNIEtu` Int  AUTO_INCREMENT  NOT NULL ,
    `NomEtu   ` Varchar (50) NOT NULL ,
    `PrenomEtu` Varchar (50) NOT NULL ,
    `dateNaissance` Date NOT NULL ,
    `adresseEtu` Varchar (50) NOT NULL ,
    `villeEtu ` Varchar (50) NOT NULL ,
    `niveauEtu` Varchar (50) NOT NULL,
	CONSTRAINT Edutiant_PK PRIMARY KEY (NumCNIEtu)
);

#------------------------------------------------------------
#        Creation de la `table` Specialite
#------------------------------------------------------------

CREATE TABLE `Specialite`(
    `codeSpec` Int  AUTO_INCREMENT  NOT NULL ,
    `nomSpec` Varchar (50) NOT NULL ,
    `descSpec` Longtext NOT NULL,
	CONSTRAINT Specialite_PK PRIMARY KEY (codeSpec)
);

#------------------------------------------------------------
#        Creation de la `table` Formation
#------------------------------------------------------------

CREATE TABLE `Formation`(
    `codeForm` Int  AUTO_INCREMENT  NOT NULL ,
    `titreForm` Varchar (50) NOT NULL ,
    `dureeForm` Int NOT NULL ,
    `prixForm` Int NOT NULL,
	CONSTRAINT Formation_PK PRIMARY KEY (codeForm)
);

#------------------------------------------------------------
#        Creation de la `table` `Session`
#------------------------------------------------------------

CREATE TABLE `Session`(
    `codeSess` Int  AUTO_INCREMENT  NOT NULL ,
    `nomSess` Varchar (50) NOT NULL ,
    `dateDebut` Date NOT NULL ,
    `dateFin` Date NOT NULL,
    `codeForm` Int NOT NULL,
	CONSTRAINT Session_PK PRIMARY KEY (codeSess),
	CONSTRAINT Session_Formation_FK FOREIGN KEY (codeForm) REFERENCES Formation(codeForm)
);

#------------------------------------------------------------
#        Creation de la `table` Inscrit
#------------------------------------------------------------

CREATE TABLE `est_Inscrit`(
    `codeSess`  Int NOT NULL AUTO_INCREMENT,
    `NumCNIEtu` Int NOT NULL ,
    `typeCours` Varchar NOT NULL,
	CONSTRAINT est_Inscrit_PK PRIMARY KEY (codeSess,NumCNIEtu),
	CONSTRAINT est_Inscrit_Session_FK FOREIGN KEY (codeSess) REFERENCES Session(codeSess),
	CONSTRAINT est_Inscrit_Edutiant0_FK FOREIGN KEY (NumCNIEtu) REFERENCES Edutiant(NumCNIEtu)
);

#------------------------------------------------------------
#        Creation de la `table` Appartient
#------------------------------------------------------------

CREATE TABLE `Appartient`(
    `codeSpec` Int NOT NULL ,
    `codeForm` Int NOT NULL,
	CONSTRAINT Appartient_PK PRIMARY KEY (codeSpec,codeForm),
	CONSTRAINT Appartient_Specialite_FK FOREIGN KEY (codeSpec) REFERENCES Specialite(codeSpec),
	CONSTRAINT Appartient_Formation0_FK FOREIGN KEY (codeForm) REFERENCES Formation(codeForm)
);

#---------------------------------------------------------------------------------
#        Ajout de la contrainte 'check' sur le champ dateFin de la 'table Session'
#---------------------------------------------------------------------------------

ALTER TABLE `Session`  ADD CHECK(dateFin > dateDebut);

#---------------------------------------------------------------------------------
#        Ajout de la colonne Active dans la 'table Specialite'
#---------------------------------------------------------------------------------

ALTER TABLE `Specialites` ADD `Active` BOOLEAN;
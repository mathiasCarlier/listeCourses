#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: LC_role
#------------------------------------------------------------

CREATE TABLE LC_role(
        idRole Int  Auto_increment  NOT NULL ,
        label  Varchar (50) NOT NULL
	,CONSTRAINT LC_role_PK PRIMARY KEY (idRole)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_users
#------------------------------------------------------------

CREATE TABLE LC_users(
        id             Int  Auto_increment  NOT NULL ,
        name           Varchar (250) NOT NULL ,
        first_name     Varchar (250) NOT NULL ,
        last_name      Varchar (250) NOT NULL ,
        mdp            Varchar (500) NOT NULL ,
        email          Varchar (255) NOT NULL ,
        email_verified TimeStamp ,
        idRole         Int NOT NULL
	,CONSTRAINT LC_users_PK PRIMARY KEY (id)

	,CONSTRAINT LC_users_LC_role_FK FOREIGN KEY (idRole) REFERENCES LC_role(idRole)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_magasin
#------------------------------------------------------------

CREATE TABLE LC_magasin(
        idMag  Int  Auto_increment  NOT NULL ,
        nomMag Varchar (50) NOT NULL
	,CONSTRAINT LC_magasin_PK PRIMARY KEY (idMag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_liste
#------------------------------------------------------------

CREATE TABLE LC_liste(
        idList    Int  Auto_increment  NOT NULL ,
        nomListe  Varchar (50) NOT NULL ,
        date_crea Date NOT NULL ,
        id        Int NOT NULL
	,CONSTRAINT LC_liste_PK PRIMARY KEY (idList)

	,CONSTRAINT LC_liste_LC_users_FK FOREIGN KEY (id) REFERENCES LC_users(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_qualite
#------------------------------------------------------------

CREATE TABLE LC_qualite(
        idQual Int  Auto_increment  NOT NULL ,
        type   Varchar (50) NOT NULL
	,CONSTRAINT LC_qualite_PK PRIMARY KEY (idQual)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_rayon
#------------------------------------------------------------

CREATE TABLE LC_rayon(
        idMag   Int NOT NULL ,
        idRay   Int NOT NULL ,
        libelle Varchar (50) NOT NULL ,
        ordre   Int NOT NULL
	,CONSTRAINT LC_rayon_PK PRIMARY KEY (idMag,idRay)

	,CONSTRAINT LC_rayon_LC_magasin_FK FOREIGN KEY (idMag) REFERENCES LC_magasin(idMag)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_lieu_de_stock
#------------------------------------------------------------

CREATE TABLE LC_lieu_de_stock(
        id      Int NOT NULL ,
        idPlac  Int NOT NULL ,
        nomLieu Varchar (50) NOT NULL
	,CONSTRAINT LC_lieu_de_stock_PK PRIMARY KEY (id,idPlac)

	,CONSTRAINT LC_lieu_de_stock_LC_users_FK FOREIGN KEY (id) REFERENCES LC_users(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_unite
#------------------------------------------------------------

CREATE TABLE LC_unite(
        idUnit  Int  Auto_increment  NOT NULL ,
        nomUnit Varchar (50) NOT NULL
	,CONSTRAINT LC_unite_PK PRIMARY KEY (idUnit)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_produit
#------------------------------------------------------------

CREATE TABLE LC_produit(
        idAlim     Int  Auto_increment  NOT NULL ,
        nomProduit Varchar (50) NOT NULL ,
        idUnit     Int NOT NULL
	,CONSTRAINT LC_produit_PK PRIMARY KEY (idAlim)

	,CONSTRAINT LC_produit_LC_unite_FK FOREIGN KEY (idUnit) REFERENCES LC_unite(idUnit)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_element_liste
#------------------------------------------------------------

CREATE TABLE LC_element_liste(
        idList Int NOT NULL ,
        idAlim Int NOT NULL ,
        qte    Float NOT NULL ,
        idQual Int NOT NULL
	,CONSTRAINT LC_element_liste_PK PRIMARY KEY (idList,idAlim)

	,CONSTRAINT LC_element_liste_LC_liste_FK FOREIGN KEY (idList) REFERENCES LC_liste(idList)
	,CONSTRAINT LC_element_liste_LC_produit0_FK FOREIGN KEY (idAlim) REFERENCES LC_produit(idAlim)
	,CONSTRAINT LC_element_liste_LC_qualite1_FK FOREIGN KEY (idQual) REFERENCES LC_qualite(idQual)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_préfère aller dans
#------------------------------------------------------------

CREATE TABLE LC_prefere_aller_dans(
        idMag Int NOT NULL ,
        id    Int NOT NULL
	,CONSTRAINT prefere_aller_dans_PK PRIMARY KEY (idMag,id)

	,CONSTRAINT prefere_aller_dans_LC_magasin_FK FOREIGN KEY (idMag) REFERENCES LC_magasin(idMag)
	,CONSTRAINT prefere_aller_dans_LC_users0_FK FOREIGN KEY (id) REFERENCES LC_users(id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_appartient a
#------------------------------------------------------------

CREATE TABLE LC_appartient_a(
        idMag  Int NOT NULL ,
        idRay  Int NOT NULL ,
        idAlim Int NOT NULL
	,CONSTRAINT appartient_a_PK PRIMARY KEY (idMag,idRay,idAlim)

	,CONSTRAINT appartient_a_LC_rayon_FK FOREIGN KEY (idMag,idRay) REFERENCES LC_rayon(idMag,idRay)
	,CONSTRAINT appartient_a_LC_produit0_FK FOREIGN KEY (idAlim) REFERENCES LC_produit(idAlim)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: LC_est dans
#------------------------------------------------------------

CREATE TABLE LC_est_dans(
        idAlim Int NOT NULL ,
        id     Int NOT NULL ,
        idPlac Int NOT NULL
	,CONSTRAINT est_dans_PK PRIMARY KEY (idAlim,id,idPlac)

	,CONSTRAINT est_dans_LC_produit_FK FOREIGN KEY (idAlim) REFERENCES LC_produit(idAlim)
	,CONSTRAINT est_dans_LC_lieu_de_stock0_FK FOREIGN KEY (id,idPlac) REFERENCES LC_lieu_de_stock(id,idPlac)
)ENGINE=InnoDB;


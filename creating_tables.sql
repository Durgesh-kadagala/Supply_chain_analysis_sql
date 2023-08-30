/*• In this file we are creating a tables from dataset*/

--prducts table

CREATE TABLE `supply_chain_data`.`products` (
  `SKU` VARCHAR(50) NOT NULL,
  `Product type` VARCHAR(45) NULL,
  `Price` DECIMAL NULL,
  `Availability` INT NULL,
  PRIMARY KEY (`SKU`));


--inventory

CREATE TABLE `supply_chain_data`.`inventory` (
  `SKU` VARCHAR(50) NOT NULL,
  `Stock levels` INT NULL,
  `Lead times` INT NULL,
  `Production volumes` INT NULL,
  `Manufacturing lead time` INT NULL,
  `Manufacturing costs` DECIMAL NULL,
  `Inspection results` VARCHAR(45) NULL,
  `Defect rates` DECIMAL NULL,
  PRIMARY KEY (`SKU`),
  CONSTRAINT `SKU`
    FOREIGN KEY (`SKU`)
    REFERENCES `supply_chain_data`.`products` (`SKU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

--sales

CREATE TABLE `supply_chain_data`.`sales` (
  `SKU` VARCHAR(50) NOT NULL,
  `Number of products sold` INT NULL,
  `Revenue generated` DECIMAL NULL,
  `Customer demographics` VARCHAR(45) NULL,
  `Order quantities` INT NULL,
  PRIMARY KEY (`SKU`),
  CONSTRAINT `SKU`
    FOREIGN KEY (`SKU`)
    REFERENCES `supply_chain_data`.`products` (`SKU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


--shipping
CREATE TABLE `supply_chain_data`.`shipping` (
  `SKU` VARCHAR(50) NOT NULL,
  `Shipping times` INT NULL,
  `Shipping carriers` VARCHAR(45) NULL,
  `Shipping costs` DECIMAL NULL,
  `Location` VARCHAR(45) NULL,
  `Transportation modes` VARCHAR(45) NULL,
  `Routes` VARCHAR(45) NULL,
  `Costs` DECIMAL NULL);

-- suppliers
CREATE TABLE `supply_chain_data`.`suppliers` (
  `Supplier name` VARCHAR(50) NOT NULL,
  `Location` VARCHAR(45) NULL,
  `Lead time` INT NULL,
  PRIMARY KEY (`Supplier name`));

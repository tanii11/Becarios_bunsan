-- Estuve realizando mis pruebas con la ayuda de DBeaver, y al momento de ejecutar los Querys 
-- me pedia que le asignara un valor a las variables y fue asi como estuve trabajando. 
BEGIN; 

\set product_code 5
\set product_quantity 10
\set user_id 2


  --Consulta para validar que el producto se encuentre disponible para venta y la cantidad que se pide sea mayor a lo que hay
  SELECT * FROM product WHERE id = :product_code AND available_for_selling = true AND stock > :product_quantity;
 
  --Actualiza la tabla product si se cumple el select anterior
  UPDATE product SET stock = stock - :product_quantity WHERE id = :product_code;
 
  --Consultamos de nuevo la tabla product para revisar que se haya hecho la modificación en el campo del stock
  SELECT product, stock  FROM product WHERE id = :product_code  AND stock > :product_quantity AND available_for_selling = TRUE;

  --Insertamos  la venta a nuestra tabla sales con los campos ya validados
  INSERT INTO sales (amount, id_product, id_users) VALUES (:product_quantity, :product_code, :user_id);
 
  --Consultamos la tabla sales para verificar que se haya isertado correctamente la venta
  SELECT  * FROM sales; 
 
COMMIT;


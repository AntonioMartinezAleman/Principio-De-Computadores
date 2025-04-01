# Solución PR3 curso 23-24
# Manejo de matrices con funciones
# Antonio Martinez Aleman
# alu0101548029@ull.edu.es
# Ultima modificación: 12/04/2024
nFil = 0	# El desplazamiento al campo dentro de la estructura
nCol = 4	# El desplazamiento al campo dentro de la estructura
elementos = 8	# El desplazamiento al campo dentro de la estructura
sizeF = 4	# Numero de bytes de un float
LF = 10		# Caracter salto de línea
	.data

mat1:	.word	6
	.word	6
	.float	11.11, 12.12, 13.13, 14.14, 15.15, 16.16,
	.float	21.21, 22.22, 23.23, 24.24, 25.25, 26.26,
	.float	31.31, 32.32, 33.33, 34.34, 35.35, 36.36,
	.float	41.41, 42.42, 43.43, 44.44, 45.45, 46.46,
	.float	51.51, 52.52, 53.53, 54.54, 55.55, 56.56,
	.float	61.61, 62.62, 63.63, 64.64, 65.65, 66.66

mat2:	.word	7
	.word	10
	.float	-36.886, -58.201,  78.671,  19.092, -50.781,  33.961, -59.511, 12.347,  57.306,  -1.938,
	.float	-86.858, -81.852,  54.623, -22.574,  88.217,  64.374,  52.312, 47.918, -83.549,  19.041,
	.float	4.255, -36.842,  82.526,  27.394,  56.527,  39.448,  18.429, 97.057,  76.933,  14.583,
	.float	67.79 ,  -9.861, -96.191,  32.369, -18.494, -43.392,  39.857, 80.686, -36.87 , -17.786,
	.float	30.073,  89.938,  -6.889,  64.601, -85.018,  70.559, -48.853, -62.627, -60.147,  -5.524,
	.float	84.323, -51.718,  93.127, -10.757,  32.119,  98.214,  69.471, 73.814,   3.724,  57.208,
	.float	-41.528, -17.458, -64.226, -71.297, -98.745,   7.095, -79.112, 33.819,  63.531, -96.181

mat3:	.word	1
	.word	8
	.float	-36.52,  35.3 ,  79.05, -58.69, -55.23, -19.44, -88.63, -93.61

mat4:	.word	16
	.word	1
	.float	-90.57, -65.11, -58.21, -73.23, -89.38, -79.25,  16.82,  66.3
	.float	-96.14, -97.16, -24.66,   5.27, -33.5 , -13.09,  27.13, -74.83

mat5:	.word	1
	.word	1
	.float	78.98

mat6:	.word	0
	.word	0
	.float	0.0

# float infinito = INFINITY;
infinito:	.word	0x7F800000

# Cadenas de caracteres
str_titulo:	.asciiz	"\nComienza programa manejo matrices con funciones\n"
str_menu:	.ascii	"(0) Terminar el programa\n"
		.ascii	"(1) Cambiar la matriz de trabajo\n"
		.ascii	"(3) Cambiar el valor de un elemento\n"
		.ascii	"(4) Intercambiar un elemento con su opuesto\n"
		.ascii	"(7) Encontrar el minimo\n"
		.asciiz	"\nIntroduce opción elegida: "
str_errorOpc:	.asciiz	"Error: opcion incorrecta\n"
str_termina:	.asciiz	"\nTermina el programa\n"
str_elijeMat:	.asciiz	"\nElije la matriz de trabajo (1..6): "
str_numMatMal:	.asciiz	"Numero de matriz de trabajo incorrecto\n"
str_errorFil:	.asciiz	"Error: dimension incorrecta.  Numero de fila incorrecto\n"
str_errorCol:	.asciiz	"Error: dimension incorrecta.  Numero de columna incorrecto\n"
str_indFila:	.asciiz	"\nIndice de fila: "
str_indCol:	.asciiz	"Indice de columna: "
str_nuevoValor:	.asciiz	"Nuevo valor para el elemento: "
str_valMin:	.asciiz	"\nEl valor minimo esta en ("
str_conValor:	.asciiz	") con valor "
str_matTiene:	.asciiz	"\n\nLa matriz tiene dimension "




  .text

print_mat:
   # void print_mat(structMat* mat) {
  #   int nFil = mat->nFil;
  lw $s1,nFil($a0) 
  #   int nCol = mat->nCol;
  lw $s2,nCol($a0)
  #   float* elem = mat->elementos;
  addi $s3,$a0,elementos
  #   std::cout << "\n\nLa matriz tiene dimension " << nFil << 'x' << nCol << '\n';
  li $v0,4
  la $a0,str_matTiene
  syscall

  move $a0,$s1
  li $v0,1
  syscall

  li $v0, 11
  li $a0, 'x'
  syscall

  move $a0,$s2
  li $v0,1
  syscall

  li $v0,11
  la $a0,LF
  syscall

  #   for(int f = 0; f < nFil; f++) {
  li $s4,0 # cargo f en s4
  for_1_start:
  bge $s4,$s1,for_1_fin

  #     for(int c = 0; c < nCol; c++) {
  li $s5,0 # cargo c en s5
  for_2_start:
  bge $s5,$s2,for_2_fin

  #       std::cout << elem[f*nCol + c] << ' ';
  mul $t1,$s4,$s2   # Multiplica la fila por el número de columnas
  add $t1,$t1,$s5   # Suma el índice de columna para obtener la posición correcta en la fila
  mul $t1,$t1,sizeF  # Multiplica por el tamaño de un float
  add $t1,$t1,$s3   # Suma la dirección base de la matriz

  l.s $f16,0($t1)

  mov.s $f12,$f16
  li $v0,2
  syscall

  li $v0,11
  la $a0,' '
  syscall

  #     }
  add $s5,$s5,1
  b for_2_start

  for_2_fin:
  #     std::cout << '\n';
  li $v0,11
  la $a0,LF
  syscall

  #   }
  addi $s4,$s4,1
  b for_1_start

  for_1_fin:
  #   std::cout << '\n';

  li $v0,11
  la $a0,LF
  syscall

  # }
print_mat_fin: jr $ra

change_elto:
  # void change_elto(structMat* mat, int indF, int indC, float valor) {
  # Recupera los registros de la pila
  l.s $f0, 12($sp)  # valor
  lw $t2, 8($sp)    # indC
  lw $t1, 4($sp)    # indF
  lw $t0, 0($sp)    # structMat*
  lw $t3, nCol($t0) # int numCol = mat->nCol;

  #   mat->elementos[indF * numCol + indC] = valor;
  mul $t4,$t1,$t3 # indF * numCol
  add $t4,$t4,$t2
  mul $t4,$t4,sizeF # elementos[indF * numCol + indC]
  add $t4,$t4,$t0 # mat->elementos[indF * numCol + indC]
  s.s $f0, elementos($t4)   #   mat->elementos[indF * numCol + indC] = valor;
  # }
change_elto_fin: jr $ra


swap:
  # void swap(float* e1, float* e2) {
  lwc1 $f4,0($a0)
  lwc1 $f6,0($a1)
  #   float temp1 = *e1;
  #   float temp2 = *e2
  swc1 $f6,0($a0)
  swc1 $f4,0($a1)
  b while_true_start
  #   *e1 = temp2;
  #   *e2 = temp1;
  # }
swap_fin:

intercambia:
  # void intercambia(structMat* mat, int indF, int indC) {
  lw $t2, 8($sp)    # indC
  lw $t1, 4($sp)    # indF
  lw $t0, 0($sp)    # structMat*
  add $sp,$sp,12
  #   int numCol = mat->nCol;
  lw $t3,nCol($t0)
  #   int numFil = mat->nFil;
  lw $t4,nFil($t0)
  #   float* datos = mat->elementos;
  add $t0,$t0,elementos
  #   float* e1 = &datos[indF * numCol + indC];
  mul $t5,$t1,$t3 # indF * numCol
  add $t5,$t5,$t2
  mul $t5,$t5,sizeF 
  add $t5,$t5,$t0 
  l.s $f4, 0($t5)
  #   float* e2 = &datos[(numFil - indF - 1) * numCol + (numCol - indC - 1)];
  sub $t6,$t4,$t1
  sub $t6,$t6,1
  mul $t6,$t6,$t3 # (numFil - indF - 1) * numCol
  sub $t7,$t3,$t2
  sub $t7,$t7,1 # (numCol - indC - 1)
  add $t6,$t6,$t7
  mul $t6,$t6,sizeF
  add $t6,$t6,$t0
  l.s $f6, 0($t6)
  
  #   swap(e1, e2);
    move $a0,$t5
    move $a1,$t6
    jal swap
    # }
intercambia_fin: jr $ra

find_min:
  # std::tuple<float, int, int> find_min(structMat* mat) {
  lw $t0,0($sp)
  #   int numCol = mat->nCol;
  lw $t1,nCol($t0)
  #   int numFil = mat->nFil;
  lw $t2,nFil($t0)
  #   float* datos = mat->elementos;
  add $t3,$t0,elementos
  #   float min = infinito;
  l.s $f6,infinito
  #   int fmin = -1;
  li $t4,-1
  #   int cmin = -1;
  li $t5,-1

  #   for(int f = 0; f < numFil; f++) {
  li $s0,0 # cargo f en s4
  for_1_min_start:
  bge $s0,$t2,for_1_min_fin

  #     for(int c = 0; c < numCol; c++) {
  li $s1,0 # cargo c en s5
  for_2_min_start:
  bge $s1,$t1,for_2_min_fin

  #       float valor = datos[f * numCol + c];
  mul $t6,$s0,$t1 # f * numCol
  add $t6,$t6,$s1 # f * numCol + c
  mul $t6,$t6,sizeF # datos[f * numCol + c]
  add $t6,$t6,$t3 # 
  l.s $f4,0($t6)

  #       if (valor < min) {
  if_min:
  c.lt.s $f4,$f6
  bc1t if_min_then
  b if_min_fin
  if_min_then:
  #         min = valor;
  mov.s $f6,$f4
  #         fmin = f;
  move $t4,$s0
  #         cmin = c;
  move $t5,$s1
  #       }
  if_min_fin:
  #     }
  add $s1,$s1,1
  b for_2_min_start

  for_2_min_fin:
  #   }
  add $s0,$s0,1
  b for_1_min_start

  for_1_min_fin:

  #   return {min, fmin, cmin};
  addi $sp,$sp,-16
  sw $t0,0($sp)
  sw $t4,4($sp)
  sw $t5,8($sp)
  s.s $f6,12($sp)
  # }

find_min_fin: jr $ra


main:
menu:

  #   std::cout << "\nComienza programa manejo matrices con funciones\n";
  li $v0,4
  la $a0,str_titulo
  syscall
  #   structMat* matTrabajo = &mat1;
  la $s0,mat1
  #   while(true) {
  while_true_start:
  #     print_mat(matTrabajo);
  addi $sp, $sp, -4    # Ajusta el puntero de pila
  sw $s0, 0($sp)

  move $a0,$s0

  jal print_mat
  #     std::cout <<
  #     "(0) Terminar el programa\n"
  #     "(1) Cambiar la matriz de trabajo\n"
  #     "(3) Cambiar el valor de un elemento\n"
  #     "(4) Intercambiar un elemento con su opuesto\n"
  #     "(7) Encontrar el minimo\n"
  #     "\nIntroduce opción elegida: ";
  li $v0,4
  la $a0,str_menu
  syscall

  #     int opcion;
  #     std::cin >> opcion;
  li $v0,5
  syscall
  move $t0,$v0
menu_fin:

#     if(opcion == 0) {
if_zero:
  bnez $t0,if_zero_fin
  #       break;
  b main_fin
  #     }
if_zero_fin:

#     if(opcion == 1) {
if_uno:
  bne $t0,1,if_uno_fin

  #       std::cout << "\nElije la matriz de trabajo (1..6): ";
  li $v0,4
  la $a0,str_elijeMat
  syscall

  #       int matT;
  #       std::cin >> matT;
  li $v0,5
  syscall
  move $t0,$v0

  #       if (matT == 1) {
  if_matriz_uno:
    bne $t0,1,if_matriz_uno_fin
    #         matTrabajo = &mat1;
    la $s0,mat1
    #         continue;  // volvemos al principio del bucle
    b while_true_start
    #       }
  if_matriz_uno_fin:
  #       if (matT == 2) {
  if_matriz_dos:
    bne $t0,2,if_matriz_dos_fin
    #         matTrabajo = &mat2;
    la $s0,mat2
    #         continue;  // volvemos al principio del bucle
    b while_true_start
    #       }
  if_matriz_dos_fin:
  #       if (matT == 3) {
  if_matriz_tres:
    bne $t0,3,if_matriz_tres_fin
    #         matTrabajo = &mat3;
    la $s0,mat3
    #         continue;  // volvemos al principio del bucle
    b while_true_start
    #       }
  if_matriz_tres_fin:
  #       if (matT == 4) {
  if_matriz_cuatro:
    bne $t0,4,if_matriz_cuatro_fin
    #         matTrabajo = &mat4;
    la $s0,mat4
    #         continue;  // volvemos al principio del bucle
    b while_true_start
    #       }
  if_matriz_cuatro_fin:
  #       if (matT == 5) {
  if_matriz_cinco:
    bne $t0,5,if_matriz_cinco_fin
    #         matTrabajo = &mat5;
    la $s0,mat5
    #         continue;  // volvemos al principio del bucle
    b while_true_start
    #       }
  if_matriz_cinco_fin:
  #       if (matT == 6) {
  if_matriz_seis:
    bne $t0,6,if_matriz_seis_fin
    #         matTrabajo = &mat6;
    la $s0,mat6
    #         continue;  // volvemos al principio del bucle
    b while_true_start
    #       }
  if_matriz_seis_fin:
  #       std::cout << "Numero de matriz de trabajo incorrecto\n";
  if_error:
    li $v0,4
    la $a0,str_numMatMal
    syscall
    #       continue;  // volvemos al principio del bucle
    #     }
    b while_true_start
if_uno_fin:

#     if(opcion == 3 || opcion == 4) {
if_tres_cuatro:
  move $s2,$t0 # guardamos en salvado el numero de opcion para utilizarlo mas tarde
  if_tres: #prueba si es 3
  bne $t0,3,if_cuatro
  b if_cuatro_then

  if_cuatro: #prueba si es 4
  bne $t0,4,if_tres_cuatro_fin
  if_cuatro_then:
  #       std::cout << "\nIndice de fila: ";
  move $s7,$t0 #guardamos en un registro salvado porque hay llamadas al sistemas
  li $v0,4
  la $a0,str_indFila
  syscall
  #       int indFil;
  #       std::cin >> indFil;
  li $v0,5
  syscall
  move $t1,$v0
  move $s3,$t1 # guardo en registro salvado indFil
  #       if ((indFil < 0) || (indFil >= matTrabajo->nFil)) {
  if_fila_primero_start:
    bgez $t1,if_fila_segundo_start
    b if_fila_segundo_then
  if_fila_segundo_start:
    lw $s0, 0($sp)       # Recupera el valor de $s0 desde la pila
    addi $sp, $sp, 4     # restaura puntero de pila
    lw $s1,nFil($s0)
    blt $t1,$s1,if_fila_primero_fin
  if_fila_segundo_then:
  #         std::cerr << "Error: dimension incorrecta.  Numero de fila incorrecto\n";
  li $v0,4
  la $a0,str_errorFil
  syscall
  #         continue;  // volvemos al principio del bucle
  b while_true_start
  #       }
  if_fila_primero_fin:
  #       std::cout << "Indice de columna: ";
  li $v0,4
  la $a0,str_indCol
  syscall
  #       int indCol;
  #       std::cin >> indCol;
  li $v0,5
  syscall
  move $t1,$v0
  move $s4,$t1 # guardo indCol en un registro salvado
  #       if ((indCol < 0) || (indCol >= matTrabajo->nCol)){
  if_columna_primero_start:
    bgez $t1,if_columna_segundo_start
    b if_columna_segundo_then
  if_columna_segundo_start:
    lw $s1,nCol($s0)
    blt $t1,$s1,if_columna_primero_fin
  if_columna_segundo_then:
  #         std::cerr << "Error: dimension incorrecta.  Numero de columna incorrecta\n";
  li $v0,4
  la $a0,str_errorCol
  syscall
  #         continue;  // volvemos al principio del bucle
  b while_true_start
  #       }
  if_columna_primero_fin:

  #       if (opcion == 3) {
  if_final_tres:
  bne $s2,3,if_final_cuatro
  #         std::cout << "Nuevo valor para el elemento: ";
  li $v0,4
  la $a0,str_nuevoValor
  syscall
  #         float valor;
  #         std::cin >> valor;
  li $v0,6
  syscall
  mov.s $f4,$f0
  #         change_elto(matTrabajo, indFil, indCol, valor);
  # Reserva espacio en la pila para un registro de punto flotante y tres registros de enteros (16 bytes)
  addi $sp, $sp, -16
  # Guarda los registros en la pila
  sw $s0, 0($sp)   # guarda matTrabajo en pila
  sw $s3, 4($sp)    # guarda indFil en pila
  sw $s4, 8($sp)    # guarda indCol en pila
  s.s $f4, 12($sp)  # guarda valor en pila

  jal change_elto
  addi $sp, $sp, 16
  #       }

  #       if(opcion == 4) {
  if_final_cuatro:
  bne $s2,4,if_final_cuatro_fin
  #         intercambia(matTrabajo, indFil, indCol);
  addi $sp,$sp,-12
  sw $s0, 0($sp)   # guarda matTrabajo en pila
  sw $s3, 4($sp)    # guarda indFil en pila
  sw $s4, 8($sp)    # guarda indCol en pila
  jal intercambia
  #       }
  if_final_cuatro_fin:

  #       continue;
  b while_true_start
  #     }
if_tres_cuatro_fin:

#     if(opcion == 7) {
if_siete:
  bne $t0,7,if_siete_fin
  #       float valorMin;
  #       int filaMin;
  #       int columnaMin;
  #       std::tie(valorMin, filaMin, columnaMin) = find_min(matTrabajo);
  addi $sp,$sp,-4
  sw $s0,0($sp)
  jal find_min
  l.s $f20,12($sp) # valor
  lw $s1,8($sp) # columnaMin
  lw $s2,4($sp) # filaMIn
  lw $s0,0($sp)
  addi $sp,$sp,16
  #       std::cout << "\nEl valor minimo esta en (" << filaMin << ','
  #         << columnaMin <<") con valor " << valorMin;
  li $v0,4
  la $a0,str_valMin
  syscall
  move $a0,$s2
  li $v0,1
  syscall
  li $v0,11
  la $a0,','
  syscall
  move $a0,$s1
  li $v0,1
  syscall
  li $v0,4
  la $a0,str_conValor
  syscall
  mov.s $f12,$f20
  li $v0,2
  syscall
  #         continue;
  b while_true_start
  #     }
if_siete_fin:
#     else {
error_opcion:
  #     std::cout << "Error: opcion incorrecta\n";
  li $v0,4
  la $a0,str_errorOpc
  syscall

  b while_true_start
  #   }
main_fin:
  #   std::cout << "\nTermina el programa\n";

  li $v0,4
  la $a0,str_termina
  syscall
  li $v0,10
  syscall
  # }
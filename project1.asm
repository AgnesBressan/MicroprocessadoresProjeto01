ORG 0000H           ; Ponto de partida do programa

; Limpeza inicial do display de 7 segmentos
clear_display:
    MOV P1, #0FFH    ; Apaga todos os segmentos do display

verifica_botoes:
    MOV A, P2            ; Lê o estado dos botões a partir do P2
    CJNE A, #254, verifica_SW1 ; Se não for 254, checa o estado do botão SW1
    SJMP contador_025s   ; Se SW0 estiver pressionado, vai para a rotina com delay de 0,25s
verifica_SW1:
    CJNE A, #253, verifica_ambos ; Se não for 253, verifica se ambos os botões estão pressionados
    SJMP contador_1s     ; Se SW1 estiver pressionado, vai para a rotina com delay de 1s
verifica_ambos:
    CJNE A, #252, parar_contagem  ; Se ambos os botões não estiverem pressionados, para o contador
    SJMP contador_025s   ; Se ambos os botões estiverem pressionados, prioriza o delay de 0,25s

parar_contagem:
    MOV P1, #0FFH    ; Apaga o display (desliga todos os segmentos)
    SJMP verifica_botoes ; Retorna para verificar novamente o estado dos botões

; Rotina principal para exibição dos números no display
contador_025s:
    MOV P1, #0C0H       ; Exibe o número 0 no display
    CALL delay          ; Chama a sub-rotina de delay

    MOV P1, #0F9H       ; Exibe o número 1
    CALL delay

    MOV P1, #0A4H       ; Exibe o número 2
    CALL delay

    MOV P1, #0B0H       ; Exibe o número 3
    CALL delay

    MOV P1, #99H        ; Exibe o número 4
    CALL delay

    MOV P1, #92H        ; Exibe o número 5
    CALL delay

    MOV P1, #82H        ; Exibe o número 6
    CALL delay

    MOV P1, #0F8H       ; Exibe o número 7
    CALL delay

    MOV P1, #80H        ; Exibe o número 8
    CALL delay

    MOV P1, #90H        ; Exibe o número 9
    CALL delay

    SJMP verifica_botoes ; Retorna para verificar os botões após a contagem de 0 a 9

contador_1s:
    MOV P1, #0C0H       ; Exibe o número 0 no display
    CALL delay          ; Chama a sub-rotina de delay

    MOV P1, #0F9H       ; Exibe o número 1
    CALL delay

    MOV P1, #0A4H       ; Exibe o número 2
    CALL delay

    MOV P1, #0B0H       ; Exibe o número 3
    CALL delay

    MOV P1, #99H        ; Exibe o número 4
    CALL delay

    MOV P1, #92H        ; Exibe o número 5
    CALL delay

    MOV P1, #82H        ; Exibe o número 6
    CALL delay

    MOV P1, #0F8H       ; Exibe o número 7
    CALL delay

    MOV P1, #80H        ; Exibe o número 8
    CALL delay

    MOV P1, #90H        ; Exibe o número 9
    CALL delay

    SJMP verifica_botoes ; Volta para verificar os switches depois de completar a contagem de 0 a 9

delay:
    ; Verifica qual botão está pressionado e ajusta o delay
    JNB P2.0, delay_025s  ; Se SW0 estiver pressionado, vai para o delay de 0,25s
    JNB P2.1, delay_1s    ; Se SW1 estiver pressionado, vai para o delay de 1s
    JMP clear_display     ; Se nenhum botão estiver pressionado, limpa o display

delay_025s:
    MOV R2, #5           ; Ajusta o valor de R2 para gerar 0,25 segundos de delay
    SJMP delay_loop      ; Pula para o loop de delay

delay_1s:
    MOV R2, #20          ; Ajusta o valor de R2 para gerar 1 segundo de delay

delay_loop:
    MOV R1, #100         ; Ajusta o primeiro contador para o loop
delay_inner_loop:
    MOV R0, #250         ; Ajusta o segundo contador para o loop
    DJNZ R0, $           ; Decrementa R0 até zero
    DJNZ R1, delay_inner_loop  ; Decrementa R1 até zero
    DJNZ R2, delay_loop        ; Decrementa R2 até o valor desejado (5 ou 20 vezes)
    RET                  ; Retorna à rotina principal

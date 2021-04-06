
org 100h;***************************** DOTS AND BOXES- A FINAL REQUREMENT FOR COE321-ASSEMBLY LANGUAGE PROGRAMMING *****************************
    GAME_RUN:
    CALL LOAD_ELEMENTS                    ;THE PROGRAM CALLS LOAD_ELEMENTS TO LOAD THE GAME'S GRAPHICS
    CALL TURN
    
       HERE:                              ;MOUSE INTERRUPT.WHERE THE INPUT HAPPENS
        MOV AX,0003H                      ;ONLY ACCEPTS LEFT MOUSE BUTTON AS INPUT
        INT 33H
        CMP BL,1H 
        JNZ HERE                          ;EXIT LOOP AND PROCEED WITH INPUT PROCESSING IF THE PLAYER PRESSES THE LMB
                                          
    CHBOXES:                               
    CALL TURNRESET                         ;TURNRESET RESETS THE TURN WHEN PLAYER 2 IS FINISHED.TURN LOADS THE INDICATOR FOR THE CURRENT TURN.
    CALL TURN                                   ;PLAYER INPUT IS TRANSFERRED TO VAR ACTPLAYER(FOR DEBUGGING PURPOSES)
    MOV [ACTPLAYER+0],DX                ; THE LOGIC OF THIS SWITCH IS THAT IT FIRST COMPARES THE INPUT TO THE FOUR ROWS AVAILABLE FOR INPUT
    MOV [ACTPLAYER+2],CX 
    INC MOVECOUNT
                                        ;AN IMPROVISED SWITCH.THIS SECTION OF THE CODE COMPARES THE VERTICAL COORDINATES
                                        ;OF THE PLAYER'S INPUT WITH THE COORDINATES BELOW THE BARS(GREEN LINES).THE GREEN BARS ARE DEFINED AREAS WHERE THE PLAYER CAN PLACE HIS/HER MOVES.
    CMP [ACTPLAYER+0],10H               ;BASICALLY, THE PROGRAM WILL COMPARE FIRST THE INPUT WITH RESPECT TO THE Y-AXIS OF THE SCREEN AND WHEN IT SATISIES ONE OF THE VALID FIELDS,IT MOVES TO THE  X-AXIS SCAN.  
    JNG ERROR_MSG                       ;ROW1- ABOVE BOXES 1,2,3  <HORIZONTAL BARS>                          
    CMP [ACTPLAYER+0],17H              
    JNG CHBAR1                          
    CMP [ACTPLAYER+0],37H               ;ROWS BET. 1-2-3 AND 4-5-6<VERTICAL BARS>
    JNG CHBAR1X
    CMP [ACTPLAYER+0],3FH               ;ROW2- ABOVE BOXES 4,5,6<HORIZONTAL BARS>    
    JNG CHBAR2
    CMP [ACTPLAYER+0],5EH               ;ROWS BET. 4-5-6 AND 7-8-9  <VERTICAL BARS>
    JNG CHBAR2X
    CMP [ACTPLAYER+0],5FH               ;ROW3-ABOVE BOXES 789
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+0],67H
    JNG CHBAR3 
    CMP [ACTPLAYER+0],67H               ;ROWS BETW. 789 AND 10-11-12 
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+0],87H
    JNG CHBAR3X
    CMP [ACTPLAYER+0],87H               ;ROW- BOXES 10-11-12 
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+0],8FH
    JNG CHBAR4                          ;IF THE PROGRAM FINDS A VALUE THAT'S CLOSEST TO THE USER INPUT,IT JUMPS TO THE COLUMN CHECK
    JMP ERROR_MSG                       ;IN CASE ALL CASES FAIL,AN ERROR MESSAGE APPEARS
    
                          ;//////COLUMN CHECK/////////
    CHBAR1:                         ;THE FOLLOWING CASES WITH A LABEL CHBAR IS A SECONDARY CHECK TO PINPOINT THE PLAYER'S MOVE WITH RESPECT TO LATERAL VALUES OF THE BARS
    CMP [ACTPLAYER+2],5FH           ;FIRST BAR(1-2-3)
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],85H           ;LEGEND  ROWS   O 1 O 2 O 3 O  
    JNG DRAW1 
                                                   ;O 4 O 5 O 6 O
                                                   
    CMP [ACTPLAYER+2],90H                          ;O 7 O 8 O 9 O
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0B6H                         ;O 10 O 11 O 12 O
    JNG DRAW2  
    
    
    CMP [ACTPLAYER+2],0C0H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0E5H
    JNG DRAW3 
    
    
    JMP ERROR_MSG                                                     
    
    CHBAR2:                             ;SECOND ROW BARS<4-5-6>
    CMP [ACTPLAYER+2],5FH
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],85H
    JNG DRAW4 
    
    CMP [ACTPLAYER+2],90H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0B6H
    JNG DRAW5
    
    CMP [ACTPLAYER+2],0C0H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0E5H
    JNG DRAW6  
    
    CHBAR3:                         ;THIRD BAR (7-8-9)
    CMP [ACTPLAYER+2],5FH
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],85H
    JNG DRAW7 
    
    CMP [ACTPLAYER+2],90H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0B6H
    JNG DRAW8
    
    CMP [ACTPLAYER+2],0C0H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0E5H
    JNG DRAW9
    
    CHBAR4:
    CMP [ACTPLAYER+2],5FH               ;FOURTH BAR<10-11-12>
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],85H
    JNG DRAW10 
    
    CMP [ACTPLAYER+2],90H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0B6H
    JNG DRAW11
    
    CMP [ACTPLAYER+2],0C0H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0E5H
    JNG DRAW12 
    
    
                                        ;VERTICAL BAR CHECKS
    CHBAR1X:
    CMP [ACTPLAYER+2],58H              ;VERTICAL BARS BET. ROWS 1-3 AND 4-6
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],5FH
    JNG DRAW13                              ;THE FIRST BAR ON THE TOP-LEFT OF THE GRID BETWEEN BAR 1 AND BAR 4 IS ASSIGNED THE INDEX 13 
                                            ;AND THE COUNTING IS CONSECUTIVE UNTIL IT REACHES THE BOTTOM-RIGHT CORNER OF THE GRID(BET.9 AND 12)
    CMP [ACTPLAYER+2],87H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],8FH
    JNG DRAW14 
    
    CMP [ACTPLAYER+2],0B8H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0BFH
    JNG DRAW15 
    
    
    CMP [ACTPLAYER+2],0E8H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0EFH
    JNG DRAW16
    
    CHBAR2X:
    CMP [ACTPLAYER+2],58H               ;VERTICAL BARS BETWEEN ROWS 4-6 ADN 7-9
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],5FH
    JNG DRAW17
    
    CMP [ACTPLAYER+2],87H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],8FH
    JNG DRAW18 
                                           ;MORE CASES
    CMP [ACTPLAYER+2],0B8H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0BFH
    JNG DRAW19 
    
    
    CMP [ACTPLAYER+2],0E8H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0EFH
    JNG DRAW20
    
    
    CHBAR3X:                       ;VERTICAL BARS BET. 7-9 AND 10-12
    CMP [ACTPLAYER+2],50H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],5FH
    JNG DRAW21
    
    CMP [ACTPLAYER+2],87H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],8FH
    JNG DRAW22 
    
    CMP [ACTPLAYER+2],0B8H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0BFH
    JNG DRAW23 
    
    
    CMP [ACTPLAYER+2],0E8H
    JNG ERROR_MSG                                                     
    CMP [ACTPLAYER+2],0EFH
    JNG DRAW24  
    JMP ERROR_MSG                                                     
    ;/////////////////////////////////////GAME ELEMENTS LOADING FUNCTION//////////////////////////////////////////////////
    LOAD_ELEMENTS:                               ;THIS FUNCTION DISPLAYS THE GAME'S SIMPLE GRAPHICS DESIGN
    MOV AX,0001H                                 ;SCREEN IS REDUCED TO 40X25 CHAR SIZE
    INT 10H                                      
    MOV AX,0600H                                 ;THE OUTER(BLUE)GRID IS SET AND DISPLAYED
    MOV BH,09FH 
    MOV CX,010AH
    MOV DX,121EH
    INT 10H                                      ;DISPLAYS THE GREEN LINES THAT SERVES AS GUIDES OF POSSIBLE MOVES IN THE GRID
     
    DRAWGRID:
     MOV AX,0600H    
     MOV BH,0AFH                                       
     MOV CX,020BH    ;TOP BAR
     MOV DX,021DH
     INT 10H 
     MOV CX,110BH    ;BOTTOM BAR
     MOV DX,111DH
     INT 10H                                           
     MOV CX,020BH    ;VERTCAL BARS(IMAGINE THE BOXES ARE ARRANGED LIKE A CELLPHONE KEYPAD)
     MOV DX,110BH    ;1-4-7
     INT 10H 
     MOV CX,0211H    ;1-4-7/2-5-8
     MOV DX,1111H
     INT 10H
     MOV CX,0217H    ;2-5-8/7-8-9
     MOV DX,1117H
     INT 10H 
     MOV CX,021DH   ;7-8-9
     MOV DX,111DH
     INT 10H 
     MOV CX,070BH     
     MOV DX,071DH
     INT 10H                        ;MIDDLE HORIZONTAL BARS
     MOV CX,0C0BH
     MOV DX,0C1DH
     INT 10H 
     
     MOV CX,4H
     MOV AH,02H
     MOV BH,0H
     MOV DX,020BH    
    PRINTGRID:
     INT 10H                  ;LOOP PRINTS THE 3X3 GRID OF DOTS
     PUSHA
     MOV AH,09H
     LEA DX,GRID
     INT 21H
     POPA
     ADD DH,5H
     LOOP PRINTGRID
    MOV AX,0600H                ;SETS AND DISPLAYS THE PLAYER LABELS AND SCOREBOARD
    MOV BH,0F0H
    MOV CX,1100H
    MOV DX,1209H 
    INT 10H   
    MOV AH,02H
    MOV BH,00H
    MOV DX,1100H
    INT 10H
    MOV AH,09H
    LEA DX,P1LABEL
    INT 21H
    MOV AH,02H
    MOV BH,00H
    MOV DX,1200H
    INT 10H
    MOV AH,09H
    LEA DX,P2LABEL
    INT 21H
    RET                         ;END OF LOAD_ELEMENTS FUNCTION
    ;//////////////////////////////////// DRAW COLOR BOXES CASES///////////////////////////////////////////
     DRAW1:                                   ;THIS GROUP OF CASES, ALTHOUGH MEANT FOR SPECIFIC COLOR BARS ON THE GRID, SHARE A SIMILAR FORMAT
     PUSHA                                   ;DRAW CASE FORMAT
     MOV BP,1                                  ;1-PRESERVE ALL REGISTER VALUES
     CALL ISMOVELEGAL                          ;2-ASSIGN A NUMBER FOR EACH CASE TO ACT AS INDEX IN FCN. ISMOVE LEGAL
     MOV AX,0600H                              ;3-CALL ISMOVE LEGAL TO CHECK IF THE BAR IS FREE AN NOT PREVIOUSLY OCCUPIED
     CALL PLAYERCOLOR                          ;4-CALL PLAYERCOLOR TO DETERMINE WHAT COLOR TO USE IN THE PRESENT MOVE
     MOV CX,020CH                              ;5-SET BAR DIMENSIONS FOR MOVE AND DISPLAY
     MOV DX,0210H
     INT 10H                                   ;6-SET OCCUPANCY FLAG TO INFORM THE PROGRAM THAT THIS BAR WAS ALREADY TAKEN,THIS WILL BE USED
     MOV [OCCUPY+1],1H                         ;TO INFORM THE USER THAT THE BAR HAS BEEN TAKEN
     INC [BOX+1]                               ;7-ADD A POINT TO THE BOX FLAG. ONCE A BOX FLAG REACHES 4PTS. IT AUTOMATICALLY DISPLAYS A NUMBER
     POPA                                      ;CORRESPONDING TO THE PLAYER AND GIVES A POINT TO THE PLAYER WHO MADE THE MOVE
     CALL CHBOX1                               ;8-RESTORE ALL REGISTER VALUES
                                               ;9-CHECK IF MOVE COMPLETED A BOX                   
     DRAW2:
     PUSHA     
     MOV BP,2
     CALL ISMOVELEGAL 
     MOV AX,0600H                               ;IN SHORT, THE GAME'S CYCLE:
     CALL PLAYERCOLOR                           ;1-BEGINS WITH RECORDING THE COORDINATES OF THE MOUSE INPUT OF THE PLAYER
     MOV CX,0212H                               ;2-COMPARING THE INPUT WITH RESPECT TO THE Y AND X-AXIS OF VALID MOVES INSIDE THE GRID 
     MOV DX,0216H                               ;3-ENTERING THE DRAW SWITCH TO CHECK IF THE MOVE IS VALID,DISPLAY MOVE BY CURRENT PLAYER 
     INT 10H                                    ;SET ARTIFICIAL OCCUPANCY FLAGS TO INDICATE BAR HAS BEEN TAKEN.
     MOV [OCCUPY+2],1H                          ;4-ENTERING THE CHBOX SWITCH TO CHECK IF ANY BOXES WERE COMPLETED SO THAT THE PLAYER
     INC [BOX+2]                                ;MY BE REWARDED
     POPA                                       ;5-CHECK GAME WIN,IF NOT GO BACK TO ASKING THE NEXT PLAYER'SINPUT
     CALL CHBOX1
                                                          
     
     DRAW3:
     PUSHA 
     MOV BP,3 
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0218H
     MOV DX,021CH
     INT 10H 
     MOV [OCCUPY+3],1H
     INC [BOX+3] 
     POPA       
     CALL CHBOX1
                                                           
    
     DRAW4:
     PUSHA
     MOV BP,4
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR                              
     MOV CX,070CH
     MOV DX,0710H
     INT 10H 
     MOV [OCCUPY+4],1H
     INC [BOX+1]                                 ;SOME BARS ARE SHARED BY TWO BOXES<EX.BOX 1 AND 4 HAVE A BAR BETWEEN THEM I.E. BAR 4>
     INC [BOX+4]                                 ;EX: ;O     O         O         O                                                  
     POPA                                             ; BOX1     BOX2    BOX3
     CALL CHBOX1                                      ;OBAR4 O//////// O  BAR6   O
                                                      ; BOX4   
                                                      ;O     O         O         O
     DRAW5:
     PUSHA                                        ;THEREFORE, TWO FLAGS ARE BOTH SET.
     MOV BP,5
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0712H
     MOV DX,0716H
     INT 10H 
     MOV [OCCUPY+5],1H
     INC [BOX+2]                                        ;SAME FORMAT APPLIES TO EVERY OTHER CASE INSIDE THE DRAW SWITCH
     INC [BOX+5]  
     POPA       
     CALL CHBOX1
                                                         
     
     DRAW6:
     PUSHA   
     MOV BP,6H
      CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0718H
     MOV DX,071CH
     INT 10H
     CALL PLAYERCOLOR
     MOV [OCCUPY+6],1H
     INC [BOX+3]
     INC [BOX+6]    
     POPA       
     CALL CHBOX1
                                                          
    
     DRAW7:
     PUSHA     
     MOV BP,7H
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0C0CH
     MOV DX,0C10H
     INT 10H   
     MOV [OCCUPY+7],1H 
     INC [BOX+4]
     INC [BOX+7]  
     POPA       
     CALL CHBOX1
                                                          
     DRAW8:
     PUSHA   
     MOV BP,8   
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0C12H
     MOV DX,0C16H
     INT 10H 
     MOV [OCCUPY+8],1H 
     INC [BOX+5]
     INC [BOX+8]   
     POPA       
     CALL CHBOX1
                                                          
     DRAW9:
     PUSHA
     MOV BP,9       
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0C18H
     MOV DX,0C1CH
     INT 10H
     MOV [OCCUPY+9],1H
     INC [BOX+6]
     INC [BOX+9]   
     POPA       
     CALL CHBOX1
     
    
     DRAW10:
     PUSHA  
     MOV BP,10     
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,110CH
     MOV DX,1110H
     INT 10H 
     MOV [OCCUPY+10],1H
     INC [BOX+7]  
     POPA       
     CALL CHBOX1
    
     DRAW11:
     PUSHA   
     MOV BP,11     
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,1112H
     MOV DX,1116H
     INT 10H  
     MOV [OCCUPY+11],1H
     INC [BOX+8] 
     POPA
     CALL CHBOX1
    
     DRAW12:
     PUSHA   
     MOV BP,12     
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,1118H
     MOV DX,111CH
     INT 10H  
     MOV [OCCUPY+12],1H 
     INC [BOX+9]   
     POPA       
     CALL CHBOX1
                                                        
     DRAW13:                                ;/////THE FOLLOWING CASES PRINT VERTICAL BARS 
     PUSHA 
     MOV BP,13
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,030BH
     MOV DX,060BH
     INT 10H
     MOV [OCCUPY+13],1H 
     INC [BOX+1] 
     POPA     
     CALL CHBOX1
     
     DRAW14:
     PUSHA  
     MOV BP,14 
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0311H
     MOV DX,0611H
     INT 10H     
     MOV [OCCUPY+14],1H
     INC [BOX+1] 
     INC [BOX+2]   
     POPA       
     CALL CHBOX1
                                                          
      DRAW15:
     PUSHA 
     MOV BP,15   
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0317H
     MOV DX,0617H
     INT 10H
     MOV [OCCUPY+15],1H
     INC [BOX+2]
     INC [BOX+3]     
     POPA       
     CALL CHBOX1
                                                           
       
     DRAW16:
     PUSHA 
     MOV BP,16  
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,031DH
     MOV DX,061DH
     INT 10H
     MOV [OCCUPY+16],1H
     INC [BOX+3]  
     POPA       
     CALL CHBOX1
                                                          
           
     DRAW17:
     PUSHA  
     MOV BP,17
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,080BH
     MOV DX,0B0BH
     INT 10H    
     MOV [OCCUPY+17],1H
     INC [BOX+4]   
     POPA       
     CALL CHBOX1
                                                          
     DRAW18:
     MOV BP,18 
     PUSHA   
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0811H
     MOV DX,0B11H
     INT 10H 
     MOV [OCCUPY+18],1H
     INC [BOX+4]
     INC [BOX+5]     
     POPA     
     CALL CHBOX1
                                                          
      DRAW19:
     PUSHA   
     MOV BP,19
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0817H
     MOV DX,0B17H
     INT 10H 
     MOV [OCCUPY+19],1H
     INC [BOX+5]
     INC [BOX+6]     
     POPA        
     CALL CHBOX1
       
     DRAW20:
     PUSHA     
     MOV BP,20
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,081DH
     MOV DX,0B1DH
     INT 10H 
     MOV [OCCUPY+20],1H
     INC [BOX+6]   
     POPA       
     CALL CHBOX1
     
      DRAW21:
     PUSHA 
     MOV BP,21       
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0D0BH
     MOV DX,100BH
     INT 10H
     MOV [OCCUPY+21],1H
     INC [BOX+7]   
     POPA       
     CALL CHBOX1
                                                           
     DRAW22:
     PUSHA   
     MOV BP,22     
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0D11H
     MOV DX,1011H
     INT 10H 
     MOV [OCCUPY+22],1H
     INC [BOX+7]
     INC [BOX+8]   
     POPA       
     CALL CHBOX1
     
     
     DRAW23:
     PUSHA   
     MOV BP,23      
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0D17H
     MOV DX,1017H
     INT 10H
     MOV [OCCUPY+23],1H
     INC [BOX+8]
     INC [BOX+9]     
     POPA       
     CALL CHBOX1
     
     DRAW24:
     PUSHA   
     MOV BP,24      
     CALL ISMOVELEGAL
     MOV AX,0600H
     CALL PLAYERCOLOR
     MOV CX,0D1DH
     MOV DX,101DH
     INT 10H     
     POPA     
     MOV [OCCUPY+24],1H 
     INC [BOX+9] 
     CALL CHBOX1
       
    ;//////////////////////////////////////////////////SUB-ROUTINES////////////////////////////////////////////////
      ISMOVELEGAL:
        CMP [OCCUPY+BP],1H                         ;USER ANALYZES IF THE CERTAIN AREA WHERE THE PLAYER WANTS TO PLACE THE MOVE IS OCCUPIED
        JE OCCUPIED                                ;IF THE FLAG AT THAT INDEX IS SET,JMP TO OCCUPIED
        RET
        OCCUPIED:                                  ;GIVES BACK THE TURN OF THE PLAYER(SINCE THE EARLIER TURN WAS A MISTAKE) 
        DEC TURNCOUNT
        DEC MOVECOUNT
        CALL TURN                                   ;PRESERVE REGISTER VALUES
        PUSHA                                      ;SET ERROR MESSAGE LOCATION AND DISPLAY IT
        MOV AH,02H
        MOV BH,0H
        MOV DX,1506H
        INT 10H  
        MOV AH,09H
        LEA DX,ERRORMSG2
        INT 21H                                   
        MOV AX,0003H                                ;PREPARE AX FOR MOUSE INTERRUPT
        JMP ERR_CLR 
      ERROR_MSG:
        DEC TURNCOUNT                             ;GIVES BACK THE TURN OF THE PLAYER SINCE IT IS INVALID
        DEC MOVECOUNT                             ;DECREMENTS THE MOVE COUNTER
        CALL TURN
        PUSHA                                     ;PRESERVE VALUES
        MOV AH,02H                                ;SET LOCATION OF ERROR MESSAGE
        MOV BH,0H
        MOV DX,1506H
        INT 10H  
        MOV AH,09H
        LEA DX,ERRORMSG                           ;DISPLAY ERROR MESSAGE REMINDING PLAYER TO PLAY WITHIN THE LINES 
        INT 21H 
        MOV AX,0003H
      ERR_CLR:                                    ;LOOP WAITS FOR USER TO PRESS LMB TO PROCEED
        INT 33H
        CMP BL,1H 
        JNZ ERR_CLR 
        MOV AH,02H                                ;SET ERASE LOCATION
        MOV BH,0H
        MOV DX,01506H
        INT 10H
        MOV AH,09H                                ;ERASE ERROR MESSAGE
        LEA DX,CLR_ERR
        INT 21H 
        POPA
        JMP HERE
    
     PLAYERCOLOR:
        CMP TURNCOUNT,3H                         ;IF TURNCOUNT IS 3,THEREFORE PLAYER 2 ALREADY MADE A MOVE, THEN JUMP TO PLAYER 2 DISPLAY
        JE COLOR2
        MOV BH,0C0H                              ;SETS BAR COLOR TO LIGHT RED FOR PLAYER 1
        RET                                      ;BH DEFINES WHAT COLOR TO BE USED IN THE BOX DISPLAY
        COLOR2: 
        MOV BH,0E0H                                   ;SETS BAR COLOR TO LIGHT RED FOR PLAYER 1
        RET
    
     TURNRESET:                                   ;RESETS TURN AFTER PLAYER 2 MAKES MOVE
        CMP TURNCOUNT,3H                         ;IF TURNCOUNT REACHES 3(MEANING PLAYER 2 ALREADY MADE A MOVE), THEN RESET TURNCOUNT TO 1H
        JNE TRX
        MOV TURNCOUNT,1H
        TRX:
        INC TURNCOUNT                            ;IF NOT,THEN PROCEED TO PLAYER 2(I.E TURNCOUNT=2H)
        RET
    
     BOXWIN:                                    ;DETERMINES THE NUMBER INSIDE THE BOX WHICH INDICATES THE PLAYER WHO COMPLETED THE BOX
        CMP TURNCOUNT,3H                        ;IF TURNCOUNT=3 THEREFORE PLAYER 2 MADE THE COMPLETING MOVE
        JE BW2
        MOV AH,09H                              ;ELSE PLAYER 1, TAKES THE BOX
        LEA DX,PLAYER1WIN
        INT 21H
        JMP BWE
        BW2:
        MOV AH,09H
        LEA DX,PLAYER2WIN                       ;DISPLAY 2 INSIDE THE BOX IF PLAYER 2 TOOK THE BOX
        INT 21H
        BWE:
        RET 
    
     SCORE:                                     ;INCREMENTS SCORE OF PLAYER IF THEY COMPLETE A BOX
        CMP TURNCOUNT,3H                        ;ROUTINE SCORES THE PLAYER WHO COMPLETED THE BOX AND MADE THE LATEST MOVE
        JE SCORE2                               ;MAKES USE OF TURNCOUNT TO DETERMINE THIS
        INC PLAYER1SCORE
        JMP SCOREE
        RET
        SCORE2:
        INC PLAYER2SCORE 
        SCOREE:
        RET                               
    
     DECTURNCOUNT:                              ;IF THE PLAYER GAINS A PINT BY COMPLETING THE BOX,HE EARNS AN EXTRA MOVE
        CMP TURNCOUNT,3H                        ;THIS ROUTINE MAKES THAT POSSIBLE
        JE N1                                    ;BY DECREMENTING TURNCOUNT, THE PLAYER IS GIVEN ANOTHER MOVE
        MOV TURNCOUNT,01H
        JMP N2
        N1:
        MOV TURNCOUNT,02H 
        N2: 
        RET     
                                               ;DISPLAYS THE PLAYER'S SCORE NEXT TO THE PLAYER LABEL
     UPDATESCORE:
        PUSHA
        MOV AH,2H                             ;SET SCORE LOCATION ON THE SCREEN
        MOV BH,0H
        MOV DX,1109H
        INT 10H
        MOV AH,09H                             ;DISPLAY PLAYER1 SCORE
        LEA DX,PLAYER1SCORE
        INT 21H   
        MOV AH,2H                             ;SET SCORE LOCATION
        MOV BH,0H
        MOV DX,1209H
        INT 10H                               ;DISPLAY PLAYER2 SCORE
        MOV AH,09H
        LEA DX,PLAYER2SCORE
        INT 21H 
        POPA
        RET 
    
      ISGAMEOVER: 
        CMP MOVECOUNT,18H                 
        JNE NOTOVER
        JMP END
        NOTOVER:
        RET   
    
      TURN:                                   ;INDICATES AND DETERMINES THE PLAYER WHO HOLDS THE CURRENT TURN
        PUSHA                                 ;IF TURNCOUNT=2H, THEREFORE ITS PLAYER2
        CMP TURNCOUNT,02H
        JE P2T                                ;SET COLOR BOX FOR GRAPHICS<PLAYER1>
        MOV AX,0600H                          ;GRAPHICS ARE UPDATED PER MOVE BASED ON WHOSE TURN IS IT
        MOV BH,0CFH
        MOV CX,1300H
        MOV DX,1309H
        INT 10H 
        MOV AH,02H                            
        MOV BH,0H
        MOV DX,1300H
        INT 10H 
        MOV AH,09H                           ;DISPLAY TURN INDICATOR <GRAPHICS>
        LEA DX,P1TURN
        INT 21H
        JMP TE
       P2T:
        MOV AX,0600H
        MOV BH,0E0H                          ;SET COLOR BOX FOR GRAPHICS<PLAYER2>
        MOV CX,1300H
        MOV DX,1309H
        INT 10H 
        MOV AH,02H
        MOV BH,0H
        MOV DX,1300H
        INT 10H                             ;DISPLAY TURN INDICATOR FOR PLAYER 2
        MOV AH,09H
        LEA DX,P2TURN
        INT 21H
       TE:
        POPA
        RET
        END:                               ;END SUB ROUTINE DECLARES WINNER AND HALTS THE PROGRAM
        MOV AH,02H
        MOV BH,0H
        MOV DX,130BH
        INT 10H 
        MOV AX,0600H
        MOV BH,6FH                       ;DISPLAY FINAL SCORES
        MOV CX,130AH
        MOV DX,1318H
        INT 10H
        MOV AL,PLAYER1SCORE 
        MOV BL,PLAYER2SCORE  
        CMP AL,BL
        JLE P2
        MOV AH,09H
        LEA DX,WIN_MSG1                   ;MESSAGE IF PLAYER 1 WINS
        INT 21H
        JMP END1
        P2: 
        MOV AH,09H
        LEA DX,WIN_MSG2                  ;MESSAGE IF PLAYER 2 WINS
        INT 21H
        JMP END1
        END1:
        MOV AH,09H                         ;DISPLAY PRESS ANY KEY TO CONTINUE
        LEA DX,PRESSKEY
        INT 21H
        MOV AH,01H
        INT 21H                            ;ASK FOR ANY INPUT TO ACT AS SYSTEM PAUSE
        JMP E2:
        E2:
        JMP EXIT                            
    ;///////////////////////////////////CHECK BOX SWITCH///////////////////////// ;CHECKS IF CURRENT MOVE FORMS A BOX
     CHBOX1:                             ;GENERAL FORMAT OF CASES
     CMP [BOX+1],4H                     ;1- THE PROGRAM DETERMINES IF THE BOX IS COMPLETED(4 POINTS SINCE A BXOX HAS 4 SIDES) 
     JNE CHBOX2                             ;IF THE CURRENT BOX IS NOT YET COMPLETED,IT MOVES TO CHECKING THE ADJACENT BOX CONSECUTIVELY
     INC [BOX+1]                            ;THE SCAN DOESN'T BREAK FROM A CASE IN ORDER TO TAKE INTO ACCOUNT THE POSSIBILITY OF COMPLETING TWO BOXES IN ONE MOVE
     PUSHA                              ;2-IF BOX IS COMPLETED,INCREMENT THE BOX POINT AGAIN SO THAT THE CASE WILL NOT BE RE-ACTIVATED
     MOV AH,02H 
     MOV BH,0H
     MOV DX,050EH
     INT 10H                            ;3-CALL BOXWIN TO DETERMINE WHO MADE THE WINNING MOVE
     CALL BOXWIN                        ;4-CALL SCORE TO GIVE THE POINT TO THE PLAYER WHO MADE THE MOVE
     CALL SCORE                         ;5-CALL UPDATE SCORE TO UPDATE THE SCORE INDICATED IN THE SCOREBOARD
     CALL UPDATESCORE                   ;6-CALL DECTURNCOUNT- TO GIVE THE PLAYER WHO WON ANOTHER TURN
     CALL DECTURNCOUNT                  ;7-CALL TURN-UPDATES THE GRAPHICS OF THE TURN INDICATOR
     CALL TURN
     POPA
     CALL ISGAMEOVER                    ;8-CALL ISGAMOVER-CHECKS IF NO MORE MOVES CAN BE MADE AND THUS THE GAME IS OVER
     JMP CHBOX2                         ;9-IF THERE ARE STILL OPEN BARS, RETURN TO MOUSE INPUT
    
     CHBOX2:
     CMP [BOX+2],4H
     JNE CHBOX3 
     INC [BOX+2]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,0514H
     INT 10H  
     CALL BOXWIN
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL TURN
     POPA
     CALL ISGAMEOVER 
     JMP CHBOX3
    
     CHBOX3:
     CMP [BOX+3],4H
     JNE CHBOX4  
     INC [BOX+3]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,051AH
     INT 10H
     CALL BOXWIN 
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL TURN
     POPA
     CALL ISGAMEOVER
     JMP CHBOX4  
    
     CHBOX4:
     CMP [BOX+4],4H
     JNE CHBOX5 
     INC [BOX+4]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,090EH
     INT 10H
     CALL BOXWIN
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL TURN
     POPA
     CALL ISGAMEOVER 
     JMP CHBOX5
     
     CHBOX5:
     CMP [BOX+5],4H
     JNE CHBOX6
     PUSHA  
     INC [BOX+5]
     MOV AH,02H 
     MOV BH,0H
     MOV DX,0914H
     INT 10H
     CALL BOXWIN
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL TURN
     POPA 
     CALL ISGAMEOVER        
     JMP CHBOX6
    
     CHBOX6:                                  ;MORE CASES
     CMP [BOX+6],4H
     JNE CHBOX7 
     INC [BOX+6]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,091AH
     INT 10H
     CALL BOXWIN
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL TURN
     POPA
     CALL ISGAMEOVER
     JMP CHBOX7
    
     CHBOX7:
     CMP [BOX+7],4H
     JNE CHBOX8 
     INC [BOX+7]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,0F0EH
     INT 10H
     CALL BOXWIN
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL TURN
     CALL ISGAMEOVER
     POPA    
     JMP CHBOX8
    
     CHBOX8:
     CMP [BOX+8],4H
     JNE CHBOX9 
     INC [BOX+8]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,0F14H
     INT 10H
     CALL BOXWIN     
     CALL SCORE      
     CALL UPDATESCORE
     CALL TURN
     POPA         
     CALL DECTURNCOUNT
     CALL ISGAMEOVER
     JMP CHBOX9 
    
     CHBOX9:
     CMP [BOX+9],4H
     JNE N3         
     INC [BOX+9]
     PUSHA
     MOV AH,02H 
     MOV BH,0H
     MOV DX,0F1AH
     INT 10H
     CALL BOXWIN
     CALL SCORE      
     CALL UPDATESCORE
     CALL DECTURNCOUNT
     CALL ISGAMEOVER 
     CALL TURN
     POPA
     N3:
     JMP HERE  
;********************* VARIABLES**************************
GRID DB 'O     O     O     O',0DH,0AH,'$'               
ACTPLAYER DW 0H,'$'                               ;HOLDS THE COORDINATES OF THE PLAYER'S MVE
PLAYER1WIN DB 31H,'$'                             ;THE CHARACTERS USED TO PRINT THE NUMBER INSIDE WHEN A SQUARE IS COMPLETED 
PLAYER2WIN DB 32H,'$'
ERRORMSG DB 'PICK ONLY THE LINES A YOUR MOVES.$'             ;ERROR MESAGE TO REMIND THE PLAYER TO PLA WITHIN THE BOUNDARIES
ERRORMSG2 DB 'THE LINE IS ALREADY OCCUPIED.$'                ;ERROR MESSAGE2 TO INDICATE THAT A BAR HAS BEEN OCCUIED
CLR_ERR DB '                                               $' ;CLEARS ERRORS
P1LABEL DB 'PLAYER 1 $'                                      ;LABELS USED IN THE SCOREBOARD
P2LABEL DB 'PLAYER 2 $'
P1TURN DB 'TURN: P1$'
P2TURN DB 'TURN: P2$'                                        ;LABELS USED IN THE TURN INDICATOR
TURNCOUNT DB 1H                                              ;WIN MESSAGES FOR BOTH PLAYERS
WIN_MSG1 DB 'PLAYER 1 WINS!',0AH,0DH,'$'
WIN_MSG2 DB  'PLAYER 2 WINS!',0AH,0DH,'$'
WIN_MSG3 DB 'PRESS ANY KEY TO CONTINUE...'
PLAYER1SCORE DB 30H,'$'                                       ;HOLDS PLAYERS SCORES
PLAYER2SCORE DB 30H,'$'
MOVECOUNT DB 0H,'$'
PRESSKEY DB 'PRESS ANY KEY TO CONTINUE.$'                   ;INPUT PROMPT TO EXIT.

;////////OCCUPANCY FLAGS/////
OCCUPY DB 24 DUP (?)                                        ;OCCUPY HOLDS THE FLAGS THAT INDICATE IF A BAR IS OCCUPIED
BOX DB 10 DUP (?)                                           ;BOX HOLDS THE FLAGS THAT INDICATE IF A BOX IS COMPLETED

;*********************************************************
EXIT:                                                       ;END GAME
END



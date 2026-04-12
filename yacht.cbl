       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO-YACHT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * 1. 輸入與輸出的基本變數
       01 WS-DICE          PIC 9(5).
       01 WS-CATEGORY      PIC X(15).
       01 WS-RESULT        PIC 99 VALUE 0.

      * 2. 統計表：記錄 1-6 點各出現幾次
       01 WS-COUNTS-TABLE.
          05 WS-COUNT      PIC 9 OCCURS 6 TIMES VALUE 0.

      * 3. 輔助變數 (迴圈與暫存用)
       01 I                PIC 9 VALUE 0.
       01 WS-DICE-AREA.
          05 WS-DICE-VAL   PIC 9 OCCURS 5 TIMES.

       PROCEDURE DIVISION.
    
       MAIN-LOGIC.
      * 模擬測試資料 (之後可以改成用 ACCEPT 讓使用者輸入)
           MOVE 11135 TO WS-DICE
           MOVE "ones" TO WS-CATEGORY
           
           PERFORM INITIALIZE-COUNT
           PERFORM PROCESS-DICE
           PERFORM CALCULATE-SCORE
           
           DISPLAY "Dice: " WS-DICE
           DISPLAY "Category: " WS-CATEGORY
           DISPLAY "Score: " WS-RESULT
           STOP RUN.

       INITIALIZE-COUNT.
      * 每次計算前把統計表歸零
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 6
               MOVE 0 TO WS-COUNT(I)
           END-PERFORM.

       PROCESS-DICE.
      * 將 9(5) 拆解並填入統計表
           MOVE WS-DICE TO WS-DICE-AREA
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
               ADD 1 TO WS-COUNT(WS-DICE-VAL(I))
           END-PERFORM.

       CALCULATE-SCORE.
           EVALUATE WS-CATEGORY
               WHEN "ones"
                  COMPUTE WS-RESULT = WS-COUNT(1) * 1
               WHEN "choice"
                      MOVE 0 TO WS-RESULT
                          PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
                              ADD WS-DICE-VAL(I) TO WS-RESULT
                          END-PERFORM
      * 這裡你可以試著挑戰寫寫看總和邏輯
           END-EVALUATE.
      *     DISPLAY "HELLO COBOL! YACHT GAME STARTING...".
      *     STOP RUN.

      *compile 檔案 cobc -x yacht.cbl
      *執行./yacht

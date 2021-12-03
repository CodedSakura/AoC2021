⎕IO←0
A←10⊥⍣¯1⊢⍎¨⊃⎕NGET'input.txt'1
B←((1⊃⍴A)÷2)<¨+/A
(2⊥B)×(2⊥~B)

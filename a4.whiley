type Word is { string w }
type Language is { [Word] l }

function equal (Word s, Word t) => (bool r)
// the length is |s.w|  and |t.w|
// if  the words are equal  then word s and t are of the same length 
  ensures r ==> |s.w| == |t.w|
// if the words are equal  then  at each index the elements in s.w and s.t are equal 
  ensures r ==> all{j in 0..|s.w| | s.w[j] == t.w[j]}
// if the words are NOT equal  then  either  word s and t are NOT of the same length or 
//     it is NOT the case that 
  ensures !r ==> (|s.w| != |t.w| || some{j in 0..|s.w| | s.w[j] != t.w[j]}):
//    WRITE function body ..
    if ( |s.w| != |t.w| ):
        return false
        
    for i in 0..|s.w|:
        if ( s.w[i] != t.w[i] ):
            return false
            
    return true
    
function contains(Word w, Language lan) => (bool r)
// if r is true then w is in pan
    ensures r ==> some{j in 0..|lan.l| | lan.l[j] == w}
// if r is false then w is not in pan
    ensures !r ==> all{j in 0..|lan.l| | lan.l[j] != w} :
    
    for x in 0..|lan.l|:
        if lan.l[x] == w:
            return true
    return false
    
function FindIdx(Word w, Language lan) => (int r)
// if r is true then w is in pan
    ensures r >= 0 ==> some{j in 0..|lan.l| | lan.l[j] == w}
// if r is false then w is not in pan
    ensures r == -1 ==> all{j in 0..|lan.l| | lan.l[j] != w}
    ensures r != -1 ==> lan.l[r] == w:
    
    int i = 0
    
    for x in 0..|lan.l|:
        if lan.l[x] == w:
            return i
        i = i + 1
    return -1

    
method main(System.Console console):
     testEqual(console)
     testContains(console)
     testFindIdx(console)
     
method testFindIdx (System.Console console):
    console.out.println("\n\nStarting Find")
    int passed = 0
    int failed = 0
    Word w = { w: "hi" }
    Language l1 = { l: [{w: "hi"}, {w: "hello"}] }
    Language l2 = { l: [{w: "how"}, {w: "are"}] }
    Language l3 = { l: [{w: "you"}, {w: "hi"}] }
    bool b1 = FindIdx(w, l1) == 0
    if b1:
        console.out.println("Test 1 passed")
        passed = passed + 1
    else:
        console.out.println("Test 1 failed")
        failed = failed + 1
    
    bool b2 = FindIdx(w, l2) == -1
    if b2:
        console.out.println("Test 2 passed")
        passed = passed + 1
    else:
        console.out.println("Test 2 failed")
        failed = failed + 1
        
    bool b3 = FindIdx(w, l3) == 1
    if b3:
        console.out.println("Test 2 passed")
        passed = passed + 1
    else:
        console.out.println("Test 2 failed")
        failed = failed + 1
        
    console.out.println("Find passed = "++passed++ " failed = "++failed)
            
            
method testContains (System.Console console):
    console.out.println("\n\nStarting Cont")
    int passed = 0
    int failed = 0
    Word w = { w: "hi" }
    Language l1 = { l: [{w: "hi"}, {w: "hello"}] }
    Language l2 = { l: [{w: "how"}, {w: "are"}] }
    bool b1 = contains(w, l1)
    if b1:
        console.out.println("Test 1 Passed")
        passed = passed + 1
    else:
        console.out.println("Test 1 Failed")
        failed = failed + 1
        
    bool b2 = !contains(w, l2)
    if b2:
        console.out.println("Test 2 Passed")
        passed = passed + 1
    else:
        console.out.println("Test 2 Failed")
        failed = failed + 1
    console.out.println("Cont passed = "++passed++ " failed = "++failed)

method testEqual (System.Console console):
    int passed = 0
    int failed = 0
    Word w1 = { w: "abc" }
    Word w2 = { w: "def" }
    Word w3 = { w: "deh" }
    Word w4 = { w: "dehx" }
    console.out.println("Starting Equ")
    bool b1 = !equal(w1,w2)
    if b1 :
        console.out.println("   test1 passed")
        passed = passed +1
    else: 
        console.out.println("   test1 failed")
        failed = failed +1
    b1 = equal(w1,w1)
    if b1 :
        console.out.println("test2 passed")
        passed = passed +1
    else: 
        console.out.println("test2 failed")
        failed = failed +1
    b1 = !equal(w3,w2)
    if b1 :
        console.out.println("test3 passed")
        passed = passed +1
    else: 
        console.out.println("test3 failed")
        failed = failed +1
    b1 = !equal(w3,w4)
    if b1 :
        console.out.println("test4 passed")
        passed = passed +1
    else: 
        console.out.println("test4 failed")
        failed = failed +1
    console.out.println("Equ passed = "++passed++ " failed = "++failed)

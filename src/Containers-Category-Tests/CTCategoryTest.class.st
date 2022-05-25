"
A CTCategoryTest is a test class for testing the behavior of CTCategory
"
Class {
	#name : #CTCategoryTest,
	#superclass : #TestCase,
	#category : #'Containers-Category-Tests'
}

{ #category : #tests }
CTCategoryTest >> addDrinkWithPriceWriter: x [

	^ x = 'beans'
		  ifTrue: [ 'milk' asWriterCategory: 25 asSumNumber asCategory ]
		  ifFalse: [ 
			  x = 'jerky'
				  ifTrue: [ 'whiskey' asWriterCategory: 99 asSumNumber asCategory ]
				  ifFalse: [ 'beer' asWriterCategory: 30 asSumNumber asCategory ] ]
]

{ #category : #tests }
CTCategoryTest >> keepSmall: each [

	"
keepSmall :: Int -> Writer [String] Bool
keepSmall x
    | x < 4 = do
        tell [""Keeping "" ++ show x]
        return True
    | otherwise = do
        tell [show x ++ "" is too large, throwing it away""]
        return False
	"

	^ each < 4
		  ifTrue: [ 
		  true asWriterCategory: { ('Keeping ' , each asString) } asCategory ]
		  ifFalse: [ 
			  false asWriterCategory:
				  { (each asString , ' is too large, throwing it away') }
					  asCategory ]
]

{ #category : #tests }
CTCategoryTest >> keepSmall: each cat: cat [

	"
keepSmall :: Int -> Writer [String] Bool
keepSmall x
    | x < 4 = do
        tell [""Keeping "" ++ show x]
        return True
    | otherwise = do
        tell [show x ++ "" is too large, throwing it away""]
        return False
	"

	^ each < 4
		  ifTrue: [ 
			  (cat tell: { ('Keeping ' , each asString) } asCategory)
			  >>= [ :_ :c | c return: true ] ]
		  ifFalse: [ 
			  (cat tell:
				   { (each asString , ' is too large, throwing it away') }
					   asCategory) >>= [ :_ :c | c return: false ] ]
]

{ #category : #tests }
CTCategoryTest >> moreStuffMonad [

	^ self stackManipMonad >>= [ :a :cat | 
	  a = 100
		  ifTrue: [ self stackStuffMonad ]
		  ifFalse: [ cat return: nil ] ]
]

{ #category : #tests }
CTCategoryTest >> pop [

	^ [ :link | link value -> link nextLink ] asState asCategory
]

{ #category : #tests }
CTCategoryTest >> push: anObject [

	^ [ :link | nil -> (anObject ~~> link) ] asState asCategory
]

{ #category : #tests }
CTCategoryTest >> stackManipMonad [

	^ (self push: 3) >> self pop >> self pop
]

{ #category : #tests }
CTCategoryTest >> stackStuffMonad [

	^ self pop >>= [ :a | 
	  a = 5
		  ifTrue: [ self push: 5 ]
		  ifFalse: [ (self push: 3) >> (self push: 8) ] ]
]

{ #category : #tests }
CTCategoryTest >> stackyStack: cat [

	^ cat get >>= [ :stateNow :aCat | 
	  | newState |
	  newState := stateNow asLinkedList asArray = { 1. 2. 3 }
		              ifTrue: [ { 8. 3. 1 } ]
		              ifFalse: [ { 9. 2. 1 } ].

	  aCat put: newState asLinkedList firstLink ]
]

{ #category : #tests }
CTCategoryTest >> testApplicativeBlock [

	"(+) <$> (+3) <*> (*100) $ 5"

	| anApplicative |
	anApplicative := [ :i | i * 100 ] asCategory
	                 <*>
	                 ([ :i | i + 3 ] asCategory <!> [ :i :j | i + j ]).

	self assert: anApplicative argument ! 5 equals: 508.

	anApplicative := [ :i | i * 100 ] asCategory
	                 <*>
	                 ([ :i | i + 3 ] asCategory
	                  <!> [ :i :j | Array with: i with: j ]).

	self assert: anApplicative argument ! 5 equals: { 8. 500 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeBlockThreeArgs [

	"(\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5"

	| anApplicative |
	anApplicative := [ :i | i / 2 ] asCategory
	                 <*>
		                 ([ :i | i * 2 ] asCategory
		                  <*> ([ :i | i + 3 ] asCategory
			                   <!> [ :i :j :k | Array with: i with: j with: k ])).

	self assert: anApplicative argument ! 5 equals: { 
			8.
			10.
			(5 / 2) }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionAppendStrings [

	"(++) <$> ['ha','heh','hmm'] <*> ['?','!','.']"

	self
		assert: { '?'. '!'. '.' } asCategory
			<*> ({ 'ha'. 'heh'. 'hmm' } asCategory <!> [ :i :j | i , j ])
		equals:
			#( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' )
				asCategory.

	self
		assert: { '?'. '!'. '.' } asCategory
			<*> ({ 'ha'. 'heh'. 'hmm' } asCategory <!> #,)
		equals:
			#( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' )
				asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionOneArgBlocks [

	"[(*0),(+100),(^2)] <*> [1,2,3]"

	self
		assert: { 1. 2. 3 } asCategory <*> { 
				[ :i | i * 0 ].
				[ :i | i + 100 ].
				[ :i | i raisedTo: 2 ] } asCategory
		equals: { 0. 0. 0. 101. 102. 103. 1. 4. 9 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionTwoArgsBlock [

	"(*) <$> [2,5,10] <*> [8,10,11]"

	self
		assert: { 8. 10. 11 } asCategory
			<*> ({ 2. 5. 10 } asCategory <!> [ :i :j | i * j ])
		equals: #( 16 20 22 40 50 55 80 100 110 ) asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionTwoArgsBlocks [

	"[(+),(*)] <*> [1,2] <*> [3,4]"

	| blocks |
	blocks := { 
		          [ :i :j | i + j ].
		          [ :i :j | i * j ] } asCategory.

	self
		assert: { 3. 4 } asCategory
			<*> ({ 1. 2 } asCategory <*> blocks)
		equals: { 4. 5. 5. 6. 3. 4. 6. 8 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeLiftA2ApplicativeMaybeCollection [

	"liftA2 (:) (Just 3) (Just [4])"

	| aJust |
	aJust := 3 asJustMaybe asCategory
		         applicative: (4 ~~> nil) asJustMaybe asCategory
		         lift: [ :obj :aLink | obj ~~> aLink ].

	self
		assert: aJust argument asArray
		equals: (3 ~~> (4 ~~> nil)) asJustMaybe asCategory argument asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequence [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTMaybeCategory new sequenceA: 3 asJustMaybe asCategory
				 ~~>
				 (2 asJustMaybe asCategory ~~> (1 asJustMaybe asCategory ~~> nil)))
				argument asArray
		equals:
		(3 ~~> (2 ~~> (1 ~~> nil))) asJustMaybe asCategory argument asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableJusts [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTMaybeCategory new sequenceAsequenceable: { 
					 3 asJustMaybe asCategory.
					 2 asJustMaybe asCategory.
					 1 asJustMaybe asCategory })
		equals: { 3. 2. 1 } asJustMaybe asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCollectionCategory new sequenceAsequenceable: { 
					 { 1. 2. 3 } asCategory.
					 { 4. 5. 6. 7 } asCategory.
					 { 8. 9 } asCategory })
		equals:
			#( #( 1 4 8 ) #( 1 4 9 ) #( 1 5 8 ) #( 1 5 9 ) #( 1 6 8 )
			   #( 1 6 9 ) #( 1 7 8 ) #( 1 7 9 ) #( 2 4 8 ) #( 2 4 9 )
			   #( 2 5 8 ) #( 2 5 9 ) #( 2 6 8 ) #( 2 6 9 ) #( 2 7 8 )
			   #( 2 7 9 ) #( 3 4 8 ) #( 3 4 9 ) #( 3 5 8 ) #( 3 5 9 )
			   #( 3 6 8 ) #( 3 6 9 ) #( 3 7 8 ) #( 3 7 9 ) ) asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableListsWithEmpty [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCollectionCategory new sequenceAsequenceable: { 
					 { 1. 2. 3 } asCategory.
					 { 4. 5. 6. 7 } asCategory.
					 { 8. 9 } asCategory.
					 {  } asCategory })
		equals: {  } asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableUnaryBlocks [

	"sequenceA [(+3),(+2),(+1)] 3"

	self
		assert: (CTBlockClosureCategory new sequenceAsequenceable: { 
					 [ :i | i + 3 ] asCategory.
					 [ :i | i + 2 ] asCategory.
					 [ :i | i + 1 ] asCategory }) argument ! 3
		equals: { 6. 5. 4 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: ((CTCollectionCategory new sequenceA: { 
					  { 1. 2. 3 } asCategory.
					  { 4. 5. 6 } asCategory } asLinkedList firstLink) argument 
				 collect: #asArray)
		equals:
			#( #( 1 4 ) #( 1 5 ) #( 1 6 ) #( 2 4 ) #( 2 5 ) #( 2 6 ) #( 3 4 )
			   #( 3 5 ) #( 3 6 ) )
]

{ #category : #tests }
CTCategoryTest >> testMonadApplicativeM [

	"[(+1),(+2),(+3)] `ap` [10,11]"

	| aMonad anotherMonad |
	aMonad := { 10. 11 } asCategory.
	anotherMonad := { 
		                [ :x | x + 1 ].
		                [ :x | x + 2 ].
		                [ :x | x + 3 ] } asCategory.

	self
		assert: aMonad <*> anotherMonad
		and: (aMonad applicativeM: anotherMonad)
		equals: { 11. 12. 12. 13. 13. 14 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadBlock [

	"

addStuff :: Int -> Int
addStuff = do
    a <- (*2)
    b <- (+10)
    return (a+b)	

	"

	| aBlockMonad |
	aBlockMonad := [ :x | x * 2 ] asCategory
	               >>= [ :a | 
	               [ :x | x + 10 ] asCategory
	               >>= [ :b :cat | cat return: a + b ] ].

	self assert: aBlockMonad argument ! 3 equals: 19
]

{ #category : #tests }
CTCategoryTest >> testMonadCountdownCollection [

	self
		skip;
		timeLimit: 1 minute.

	self
		deny: (50000 asWriterCategory: {  } asCategory)
			>>= [ :n :category | 
				self withWriterCountdown: n collectionCategory: category ]
		equals: nil
]

{ #category : #tests }
CTCategoryTest >> testMonadCountdownDifferenceCollection [

	self
		deny:
			(500000 asWriterCategory: {  } asDifferenceCollection asCategory)
			>>= [ :n :category | 
				self withWriterCountdown: n differenceCollectionCategory: category ]
		equals: nil
]

{ #category : #tests }
CTCategoryTest >> testMonadDoMaybe [

	"

foo :: Maybe String
foo = Just 3   >>= (\x ->
      Just ""!"" >>= (\y ->
		Just (show x ++ y)))
	
	"

	self
		assert: 3 asJustMaybe asCategory >>= [ :x | 
			'!' asJustMaybe asCategory
			>>= [ :y | (x asString , y) asJustMaybe asCategory ] ]
		equals: '3!' asJustMaybe asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadFish [

	"
ghci> let f x = [x,-x]
ghci> let g x = [x*3,x*2]
ghci> let h = f <=< g
ghci> h 3	
	"

	| f g |
	f := [ :x | 
	     { 
		     x.
		     x negated } asCategory ].

	g := [ :x | 
	     { 
		     (x * 3).
		     (x * 2) } asCategory ].

	self
		assert: f >=> g ! 3
		equals: { 9. -9. 6. -6 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadGuard [

	"guard (5 > 2) :: Maybe ()"

	self
		assert: (CTMaybeCategory new guard: 5 > 2)
		equals: nil asJustMaybe asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadGuardInBind [

	"[1..50] >>= (\x -> guard ('7' `elem` show x) >> return x)"

	self
		assert: (1 to: 50) asCategory >>= [ :each :category | 
			(category guard: (each asString includes: $7))
			>> (category return: each) ]
		equals: { 7. 17. 27. 37. 47 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadJoinCollections [

	"join [[1,2,3],[4,5,6]]"

	^ self
		  assert: { 
				  { 1. 2. 3 } asCategory.
				  { 4. 5. 6 } asCategory } asCategory join
		  equals: { 1. 2. 3. 4. 5. 6 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadJoinState [

	"runState (join (state $ \s -> (push 10, 1:2:s))) [0,0,0]"

	| aMonad anAssoc |
	aMonad := [ :s | (self push: 10) -> (1 ~~> (2 ~~> s)) ] asState
		          asCategory join.

	anAssoc := aMonad argument ! { 0. 0. 0 } asLinkedList firstLink.

	self assert: anAssoc key equals: nil.

	^ self
		  assert: anAssoc value asLinkedList asArray
		  equals: { 10. 1. 2. 0. 0. 0 }
]

{ #category : #tests }
CTCategoryTest >> testMonadJoinWriter [

	"runWriter $ join (Writer (Writer (1, 'aaa'), 'bbb'))"

	^ self
		  assert: ((1 asWriterCategory: 'aaa' asCategory) asWriterCategory:
				   'bbb' asCategory) join
		  equals: (1 asWriterCategory: 'bbbaaa' asCategory)
]

{ #category : #tests }
CTCategoryTest >> testMonadLiftM [

	"runWriter $ fmap not $ Writer (True, ""chickpeas"")"

	self
		assert:
			((true asWriterCategory: { 'chickpeas' } asCategory) fmap: [ 
				 :aBoolean | aBoolean not ])
		equals: (false asWriterCategory: { 'chickpeas' } asCategory)
]

{ #category : #tests }
CTCategoryTest >> testMonadLiftMState [

	"runState (fmap (+100) pop) [1,2,3,4]"

	| anAssoc |
	anAssoc := (self pop fmap: [ :x | x + 100 ]) argument
	           ! { 1. 2. 3. 4 } asLinkedList firstLink.

	self assert: anAssoc key equals: 101.

	self assert: anAssoc value asLinkedList asArray equals: { 2. 3. 4 }.

	anAssoc := (self pop liftM: [ :x | x + 100 ]) argument
	           ! { 1. 2. 3. 4 } asLinkedList firstLink.

	self assert: anAssoc key equals: 101.

	self assert: anAssoc value asLinkedList asArray equals: { 2. 3. 4 }
]

{ #category : #tests }
CTCategoryTest >> testMonadList [

	"[3,4,5] >>= \x -> [x,-x]"

	self
		assert: { 3. 4. 5 } asCategory
			>>= [ :x | (Array with: x with: x negated) asCategory ]
		equals: { 3. -3. 4. -4. 5. -5 } asCategory.

	"[1,2,3] >>= \x -> []"
	self
		assert: { 3. 4. 5 } asCategory
			>>= [ :x | {  } asCategory ]
		equals: {  } asCategory.

	"[1,2] >>= \n -> ['a','b'] >>= \ch -> return (n, ch)"
	self
		assert: { 1. 2 } asCategory >>= [ :n | 
			{ $a. $b } asCategory
			>>= [ :char :category | 
			category return: (Array with: n with: char) ] ]
		equals:
		#( #( 1 $a ) #( 1 $b ) #( 2 $a ) #( 2 $b ) ) asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadMaybe [

	"Just 9 >>= \x -> return (x*10)"

	self
		assert: 9 asJustMaybe asCategory
			>>= [ :x :category | category return: x * 10 ]
		equals: (9 * 10) asJustMaybe asCategory.

	self
		assert: self asNothingMaybe asCategory
			>>= [ :x :category | category return: x * 10 ]
		equals: self asNothingMaybe asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadPierrePoleWalking [

	| pole |
	pole := CTCategoryPole new.

	self
		assert: (((pole landLeft: 1) landRight: 1) landLeft: 2) value
		equals: 3 @ 1.

	self
		assert: (pole -! [ :p | p landLeft: 1 ] -! [ :p | p landRight: 1 ]
			 -! [ :p | p landLeft: 2 ]) value
		equals: 3 @ 1.

	self
		assert: (pole maybeLandLeft: 10) value
		equals: self asNothingMaybe asCategory.

	"return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2"
	self
		assert:
			(CTMaybeCategory new return: pole) >>= [ :p | p maybeLandRight: 2 ]
			>>= [ :p | p maybeLandLeft: 2 ] >>= [ :p | p maybeLandRight: 2 ]
		equals: (CTCategoryPole new
				 left: 2;
				 right: 4;
				 yourself) asJustMaybe asCategory.

	self
		assert: (pole -! [ :p | p landLeft: 1 ] -! [ :p | p landRight: 4 ]
			 -! [ :p | p landLeft: -1 ] -! [ :p | p landRight: -2 ]) value
		equals: 0 @ 2.

	self
		assert:
			(CTMaybeCategory new return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeLandRight: 4 ] >>= [ :p | p maybeLandLeft: -1 ]
			>>= [ :p | p maybeLandRight: -2 ]
		equals: self asNothingMaybe asCategory.

	self
		assert:
			(CTMaybeCategory new return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeBanana ] >>= [ :p | p maybeLandRight: 1 ]
		equals: self asNothingMaybe asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadPowerset [

	"powerset [1,2,3]"

	self
		assert: { 1. 2. 3. 4 } powersetM
		equals:
			#( #( 1 2 3 4 ) #( 1 2 3 ) #( 1 2 4 ) #( 1 2 ) #( 1 3 4 )
			   #( 1 3 ) #( 1 4 ) #( 1 ) #( 2 3 4 ) #( 2 3 ) #( 2 4 ) #( 2 )
			   #( 3 4 ) #( 3 ) #( 4 ) #(  ) ) asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadSelectM [

	"fst $ runWriter $ filterM keepSmall [9,1,5,2,10,3]"

	| cat |
	cat := nil asWriterCategory: {  } asCategory.

	self
		assert: ({ 9. 1. 5. 2. 10. 3 }
				 select: [ :each | self keepSmall: each cat: cat ]
				 monad: cat)
		and: ({ 9. 1. 5. 2. 10. 3 }
				 select: [ :each | self keepSmall: each ]
				 monad: cat)
		equals: ({ 1. 2. 3 } asWriterCategory:
				 #( 'Keeping 3' '10 is too large, throwing it away'
				    'Keeping 2' '5 is too large, throwing it away'
				    'Keeping 1' '9 is too large, throwing it away' ) asCategory)
]

{ #category : #tests }
CTCategoryTest >> testMonadState [

	"

stackManip :: State Stack Int
stackManip = do
    push 3
    a <- pop
    pop

	"

	| anAssoc |
	anAssoc := self stackManipMonad argument
	           ! { 5. 8. 2. 1 } asLinkedList firstLink.

	self
		assert: anAssoc key equals: 5;
		assert: anAssoc value asLinkedList asArray equals: { 8. 2. 1 }
]

{ #category : #tests }
CTCategoryTest >> testMonadStateMoreStackStuff [

	"runState stackStuff [9,0,2,1,0]"

	| anAssoc |
	anAssoc := self moreStuffMonad argument
	           ! { 100. 0. 2. 1. 0 } asLinkedList firstLink.

	self assert: anAssoc key equals: nil.

	self
		assert: anAssoc value asLinkedList asArray
		equals: { 8. 3. 2. 1. 0 }
]

{ #category : #tests }
CTCategoryTest >> testMonadStateStackStuff [

	"runState stackStuff [9,0,2,1,0]"

	| anAssoc |
	anAssoc := self stackStuffMonad argument
	           ! { 9. 0. 2. 1. 0 } asLinkedList firstLink.

	self assert: anAssoc key equals: nil.

	self
		assert: anAssoc value asLinkedList asArray
		equals: { 8. 3. 0. 2. 1. 0 }
]

{ #category : #tests }
CTCategoryTest >> testMonadStateStackyStack [

	| anAssoc |
	anAssoc := (self moreStuffMonad
	            >>= [ :x :cat | self stackyStack: cat ]) argument
	           ! { 100. 0. 2. 1. 0 } asLinkedList firstLink.

	self assert: anAssoc key equals: nil.

	self assert: anAssoc value asLinkedList asArray equals: { 9. 2. 1 }
]

{ #category : #tests }
CTCategoryTest >> testMonadWithGotNumberStringWriter [

	self
		assert: (self withGotNumberStringWriter: 3) >>= [ :x | 
			(self withGotNumberStringWriter: 5) >>= [ :y :category | 
			(category tell: { 'Gonna multiply these two' } asCategory)
			>>= [ :shouldBeNil | 
				self assert: shouldBeNil equals: nil.
				category return: x * y ] ] ]
		equals: (15 asWriterCategory:
				 { 'got number: 3'. 'got number: 5'. 'Gonna multiply these two' }
					 asCategory)
]

{ #category : #tests }
CTCategoryTest >> testMonadWriter [

	"(""dogmeat"", Sum 5) `applyLog` addDrink `applyLog` addDrink"

	self
		assert: ('dogmeat' asWriterCategory: 5 asSumNumber asCategory)
			>>= [ :x | self addDrinkWithPriceWriter: x ]
			>>= [ :x | self addDrinkWithPriceWriter: x ]
		equals: ('beer' asWriterCategory: 65 asSumNumber asCategory)
]

{ #category : #tests }
CTCategoryTest >> testMonadWriterGCD [

	self
		assert:
			(897542437 -> 854797 asWriterCategory: {  } asCategory)
			>>= [ :anAssoc :category | 
				self withWriter: anAssoc key gcd: anAssoc value category: category ]
		equals: (1 asWriterCategory:
				 { '897542437 mod: 854797 = 5587'. '854797 mod: 5587 = 5573'.
				 '5587 mod: 5573 = 14'. '5573 mod: 14 = 1'. '14 mod: 1 = 0'.
				 'Finished with: 1' } asCategory)
]

{ #category : #tests }
CTCategoryTest >> testMonadWriterGCDdifferenceCollection [

	self
		assert: ((897542437 -> 854797 asWriterCategory:
				  {  } asDifferenceCollection asCategory)
			 >>= [ :anAssoc :category | 
				 self
					 withWriter: anAssoc key
					 gcd: anAssoc value
					 differenceCollectionCategory: category ]) log
				asOrderedCollection
		equals: #( 'Finished with: 1' '14 mod: 1 = 0' '5573 mod: 14 = 1'
			   '5587 mod: 5573 = 14' '854797 mod: 5587 = 5573'
			   '897542437 mod: 854797 = 5587' )
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendCollection [

	"[1,2,3] `mappend` [4,5,6]"

	self
		assert: ({ 1. 2. 3 } asCategory mappend:
				 { 4. 5. 6 } asCategory)
		equals: { 1. 2. 3. 4. 5. 6 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendMaybeProduct [

	"Just (Product 3) `mappend` Just (Product 4)"

	self
		assert:
			(3 asProductNumber asCategory asJustMaybe asCategory mappend:
				 9 asProductNumber asCategory asJustMaybe asCategory)
		equals: 27 asProductNumber asCategory asJustMaybe asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendProduct [

	"Product 3 `mappend` Product 9"

	self
		assert:
		(3 asProductNumber asCategory mappend: 9 asProductNumber asCategory)
		equals: 27 asProductNumber asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendStrings [

	"('one' `mappend` 'two') `mappend` 'tree'"

	self
		assert:
			(('one' asCategory mappend: 'two' asCategory) 
				 mappend: 'three' asCategory)
		equals: 'onetwothree' asCategory.

	self
		assert: ('one' asCategory mappend:
				 ('two' asCategory mappend: 'three' asCategory))
		equals: 'onetwothree' asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcat [

	"mconcat [[1,2],[3,6],[9]]"

	self
		assert: (CTCollectionCategory new mconcat: { 
					 { 1. 2 } asCategory.
					 { 3. 6 } asCategory.
					 { 9 } asCategory })
		equals: { 1. 2. 3. 6. 9 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcatProduct [

	"getProduct . mconcat . map Product $ [3,4,2]"

	self
		assert: (CTProductNumberCategory new mconcat:
				 ({ 3. 4. 2 } collect: [ :each | each asProductNumber asCategory ]))
		equals: (3 * 4 * 2) asProductNumber asCategory
]

{ #category : #tests }
CTCategoryTest >> withGotNumberStringWriter: x [

	^ x asWriterCategory:
		  { ('got number: ' , x asString) } asCategory
]

{ #category : #tests }
CTCategoryTest >> withWriter: a gcd: b category: category [

	"
gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
    | b == 0 = do
        tell [""Finished with "" ++ show a]
        return a
    | otherwise = do
        tell [show a ++ "" mod "" ++ show b ++ "" = "" ++ show (a `mod` b)]
        gcd' b (a `mod` b)
"

	^ b = 0
		  ifTrue: [ 
			  (category tell:
				   { ('Finished with: ' , a asString) } asCategory)
			  >>= [ :_ :c | c return: a ] ]
		  ifFalse: [ 
			  | mod |
			  mod := a rem: b.
			  (category tell:
				   { (a asString , ' mod: ' , b asString , ' = ' , mod asString) }
					   asCategory)
			  >>= [ :_ :c | self withWriter: b gcd: mod category: c ] ]
]

{ #category : #tests }
CTCategoryTest >> withWriter: a gcd: b differenceCollectionCategory: category [

	"
gcd' :: Int -> Int -> Writer (DiffList String) Int
gcd' a b
    | b == 0 = do
       tell (toDiffList ['Finished with ' ++ show a])
       return a
    | otherwise = do
       result <- gcd' b (a `mod` b)
       tell (toDiffList [show a ++ ' mod ' ++ show b ++ ' = ' ++ show (a `mod` b)])
       return result
"

	^ b = 0
		  ifTrue: [ 
			  (category tell:
				   { ('Finished with: ' , a asString) } asDifferenceCollection
					   asCategory) >>= [ :_ :c | c return: a ] ]
		  ifFalse: [ 
			  | mod |
			  mod := a rem: b.
			  (self
				   withWriter: b
				   gcd: mod
				   differenceCollectionCategory: category) >>= [ :result :c | 
			  (c tell:
				   { (a asString , ' mod: ' , b asString , ' = ' , mod asString) }
					   asDifferenceCollection asCategory)
			  >>= [ :_ :d | d return: result ] ] ]
]

{ #category : #tests }
CTCategoryTest >> withWriterCountdown: n collectionCategory: category [

	"
finalCountDown :: Int -> Writer [String] ()
             finalCountDown 0 = do
                 tell [""0""]
             finalCountDown x = do
                 finalCountDown (x-1)
                 tell [show x]
"

	^ n = 0
		  ifTrue: [ category tell: { 0 asString } asCategory ]
		  ifFalse: [ 
			  (self withWriterCountdown: n - 1 collectionCategory: category)
			  >>= [ :result :c | c tell: { n asString } asCategory ] ]
]

{ #category : #tests }
CTCategoryTest >> withWriterCountdown: n differenceCollectionCategory: category [

	"finalCountDown :: Int -> Writer (DiffList String) ()
            finalCountDown 0 = do
                tell (toDiffList [""0""])
            finalCountDown x = do
                finalCountDown (x-1)
                tell (toDiffList [show x])"

	^ n = 0
		  ifTrue: [ 
		  category tell: { 0 asString } asDifferenceCollection asCategory ]
		  ifFalse: [ 
			  (self
				   withWriterCountdown: n - 1
				   differenceCollectionCategory: category) >>= [ :result :c | 
			  c tell: { n asString } asDifferenceCollection asCategory ] ]
]

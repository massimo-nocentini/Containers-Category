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
CTCategoryTest >> testApplicativeBlock [

	"(+) <$> (+3) <*> (*100) $ 5"

	| anApplicative category |
	category := CTCategory block.

	anApplicative := (category on: [ :i | i * 100 ])
	                 <*>
	                 ((category on: [ :i | i + 3 ]) <!> [ :i :j | i + j ]).

	self assert: anApplicative argument ! 5 equals: 508.

	anApplicative := (category on: [ :i | i * 100 ])
	                 <*>
	                 ((category on: [ :i | i + 3 ])
	                  <!> [ :i :j | Array with: i with: j ]).

	self assert: anApplicative argument ! 5 equals: { 8. 500 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeBlockThreeArgs [

	"(\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5"

	| anApplicative category |
	category := CTCategory block.

	anApplicative := (category on: [ :i | i / 2 ])
	                 <*>
		                 ((category on: [ :i | i * 2 ])
		                  <*> ((category on: [ :i | i + 3 ])
			                   <!> [ :i :j :k | Array with: i with: j with: k ])).

	self assert: anApplicative argument ! 5 equals: { 
			8.
			10.
			(5 / 2) }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionAppendStrings [

	"(++) <$> ['ha','heh','hmm'] <*> ['?','!','.']"

	| category |
	category := CTCategory collection.

	self
		assert: (category on: { '?'. '!'. '.' })
			<*> ((category on: { 'ha'. 'heh'. 'hmm' }) <!> [ :i :j | i , j ])
		equals: (category on:
				 #( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' )).

	self
		assert: (category on: { '?'. '!'. '.' })
			<*> ((category on: { 'ha'. 'heh'. 'hmm' }) <!> #,)
		equals: (category on:
				 #( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' ))
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
	aJust := 3 asJustMaybeCategory
		         applicative: (4 ~~> nil) asJustMaybeCategory
		         lift: [ :obj :aLink | obj ~~> aLink ].

	self
		assert: aJust argument asArray
		equals: (3 ~~> (4 ~~> nil)) asJustMaybeCategory argument asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequence [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTCategory maybe new sequenceA: 3 asJustMaybeCategory
				 ~~> (2 asJustMaybeCategory ~~> (1 asJustMaybeCategory ~~> nil)))
				argument asArray
		equals:
		(3 ~~> (2 ~~> (1 ~~> nil))) asJustMaybeCategory argument asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableJusts [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTCategory maybe new sequenceAsequenceable: { 
					 3 asJustMaybeCategory.
					 2 asJustMaybeCategory.
					 1 asJustMaybeCategory })
		equals: { 3. 2. 1 } asJustMaybeCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCategory collection new sequenceAsequenceable: ({ 
					  { 1. 2. 3 }.
					  { 4. 5. 6. 7 }.
					  { 8. 9 } } collect: [ :each | each asCategory ]))
		equals:
			#( #( 1 4 8 ) #( 1 4 9 ) #( 1 5 8 ) #( 1 5 9 ) #( 1 6 8 )
			   #( 1 6 9 ) #( 1 7 8 ) #( 1 7 9 ) #( 2 4 8 ) #( 2 4 9 )
			   #( 2 5 8 ) #( 2 5 9 ) #( 2 6 8 ) #( 2 6 9 ) #( 2 7 8 )
			   #( 2 7 9 ) #( 3 4 8 ) #( 3 4 9 ) #( 3 5 8 ) #( 3 5 9 )
			   #( 3 6 8 ) #( 3 6 9 ) #( 3 7 8 ) #( 3 7 9 ) )
				asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableListsWithEmpty [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCategory collection new sequenceAsequenceable: ({ 
					  { 1. 2. 3 }.
					  { 4. 5. 6. 7 }.
					  { 8. 9 }.
					  {  } } collect: [ :each | each asCategory ]))
		equals: {  } asCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableUnaryBlocks [

	"sequenceA [(+3),(+2),(+1)] 3"

	| category |
	category := CTCategory block.

	self
		assert: (category new sequenceAsequenceable: { 
					 (category on: [ :i | i + 3 ]).
					 (category on: [ :i | i + 2 ]).
					 (category on: [ :i | i + 1 ]) }) argument ! 3
		equals: { 6. 5. 4 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: ((CTCategory collection new sequenceA: { 
					  { 1. 2. 3 } asCategory.
					  { 4. 5. 6 } asCategory } asLinkedList firstLink)
				 argument collect: #asArray)
		equals:
			#( #( 1 4 ) #( 1 5 ) #( 1 6 ) #( 2 4 ) #( 2 5 ) #( 2 6 ) #( 3 4 )
			   #( 3 5 ) #( 3 6 ) )
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
		assert: 3 asJustMaybeCategory >>= [ :x | 
			'!' asJustMaybeCategory
			>>= [ :y | (x asString , y) asJustMaybeCategory ] ]
		equals: '3!' asJustMaybeCategory
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
		assert: (CTCategory maybe new guard: 5 > 2)
		equals: nil asJustMaybeCategory
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
		assert:
		9 asJustMaybeCategory >>= [ :x :category | category return: x * 10 ]
		equals: (9 * 10) asJustMaybeCategory.

	self
		assert: CTCategory maybe nothing
			>>= [ :x :category | category return: x * 10 ]
		equals: CTCategory maybe nothing
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
		equals: CTCategory maybe nothing.

	"return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2"
	self
		assert:
			(CTCategory maybe new return: pole)
			>>= [ :p | p maybeLandRight: 2 ] >>= [ :p | p maybeLandLeft: 2 ]
			>>= [ :p | p maybeLandRight: 2 ]
		equals: (CTCategoryPole new
				 left: 2;
				 right: 4;
				 yourself) asJustMaybeCategory.

	self
		assert: (pole -! [ :p | p landLeft: 1 ] -! [ :p | p landRight: 4 ]
			 -! [ :p | p landLeft: -1 ] -! [ :p | p landRight: -2 ]) value
		equals: 0 @ 2.

	self
		assert:
			(CTCategory maybe new return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeLandRight: 4 ] >>= [ :p | p maybeLandLeft: -1 ]
			>>= [ :p | p maybeLandRight: -2 ]
		equals: CTCategory maybe nothing.

	self
		assert:
			(CTCategory maybe new return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeBanana ] >>= [ :p | p maybeLandRight: 1 ]
		equals: CTCategory maybe nothing
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
		assert: (3 asProductNumber asCategory asJustMaybeCategory mappend:
				 9 asProductNumber asCategory asJustMaybeCategory)
		equals: 27 asProductNumber asCategory asJustMaybeCategory
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
		assert: (CTCategory collection new mconcat: { 
					 { 1. 2 } asCategory.
					 { 3. 6 } asCategory.
					 { 9 } asCategory })
		equals: { 1. 2. 3. 6. 9 } asCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcatProduct [

	"getProduct . mconcat . map Product $ [3,4,2]"

	self
		assert: (CTCategory number product new mconcat:
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

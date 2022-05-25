Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Category' }
SequenceableCollection >> asDifferenceCollection [

	^ CTCategoryDifferenceCollection new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
SequenceableCollection >> powersetM [

	"
powerset :: [a] -> [[a]]
powerset xs = filterM (\x -> [True, False]) xs
	"

	^ self
		  select: [ :each | { true. false } asCategory ]
		  monad: {  } asCategory
]

{ #category : #'*Containers-Category' }
SequenceableCollection >> select: aBlock monad: aMonad [

	"
filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]
filterM _ [] = return []
filterM p (x:xs) = do
flg <- p x
ys <- filterM p xs
return (if flg then x:ys else ys)
	"

	^ self ifEmpty: [ aMonad return: self ] ifNotEmpty: [ 
		  aBlock ! self first >>= [ :aBoolean :cat | 
		  | restMonad |
		  restMonad := self allButFirst select: aBlock monad: cat.

		  restMonad >>= [ :aLink :finalCat | 
		  | newLink |
		  newLink := aBoolean
			             ifTrue: [ self class with: self first withAll: aLink ]
			             ifFalse: [ aLink ].

		  finalCat return: newLink ] ] ]
]

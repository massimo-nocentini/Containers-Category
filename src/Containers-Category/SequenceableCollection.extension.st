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
filterM          :: (Applicative m) => (a -> m Bool) -> [a] -> m [a]
filterM p        = foldr (\ x -> liftA2 (\ flg -> if flg then (x:) else id) (p x)) (pure [])
"

	| foldedMonad |
	foldedMonad := self
		               foldr: [ :each :folded | 
			               | eachMonad |
			               eachMonad := aBlock value: each.
			               eachMonad applicative: folded lift: [ :flg :rest | 
				               flg
					               ifTrue: [ each ~~> rest ]
					               ifFalse: [ rest ] ] ]
		               init: (aMonad return: nil).

	^ foldedMonad fmap: [ :link | link asLinkedList asArray ]
]

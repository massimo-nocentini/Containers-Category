Trait {
	#name : #CTCategoryTApplicative,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <!> aBlock [

	^ self fmap: aBlock currified
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <*> anApplicative [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> liftA2: aTwoArgsBlock applicative: anApplicative [

	"

liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <$> a <*> b

"

	^ anApplicative <*> (self <!> aTwoArgsBlock)
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> pure: object [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> sequenceA: aLink [

	"
sequenceA :: (Applicative f) => [f a] -> f [a]
sequenceA [] = pure []
sequenceA (x:xs) = (:) <$> x <*> sequenceA xs
"

	^ aLink ifNil: [ self pure: nil ] ifNotNil: [ 
		  aLink value
			  liftA2: [ :obj :restLink | obj ~~> restLink ]
			  applicative: (self sequenceA: aLink nextLink) ]
]

Extension { #name : #BlockClosure }

{ #category : #'*Containers-Category' }
BlockClosure >> fmap: aBlock [

	"
	instance Functor ((->) r) where
		fmap f g = (\x -> f (g x))
	"

	^ [ :object | 
	  | value |
	  value := self value: object.
	  aBlock value: value ]
]

Extension { #name : #BlockClosure }

{ #category : #'*Containers-Category' }
BlockClosure >> >=> aBlock [

	^ [ :x | aBlock ! x >>= self ]
]

{ #category : #'*Containers-Category' }
BlockClosure >> currified [

	| size |
	size := self numArgs.

	^ size = 0
		  ifTrue: [ [ :useless | self value ] ]
		  ifFalse: [ 
			  size = 1
				  ifTrue: [ self ]
				  ifFalse: [ self class currify: self numArgs: size ] ]
]

{ #category : #'*Containers-Category' }
BlockClosure class >> currify: aBlock [

	^ self currify: aBlock numArgs: aBlock numArgs
]

{ #category : #'*Containers-Category' }
BlockClosure class >> currify: aBlock numArgs: n [

	^ self
		  currify: aBlock
		  numArgs: n
		  argsBlock: [ :aValueLink | aValueLink asArray ]
]

{ #category : #'*Containers-Category' }
BlockClosure class >> currify: aBlock numArgs: n argsBlock: argsBlock [

	^ n
		  ifZero: [ aBlock valueWithArguments: (argsBlock value: nil) ]
		  ifNotZero: [ 
			  [ :arg | 
			  self
				  currify: aBlock
				  numArgs: n - 1
				  argsBlock: [ :args | argsBlock value: arg ~~> args ] ] ]
]

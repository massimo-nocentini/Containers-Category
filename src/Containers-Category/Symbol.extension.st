Extension { #name : #Symbol }

{ #category : #'*Containers-Category' }
Symbol >> currified [

	^ self isUnary
		  ifTrue: [ Error signal ]
		  ifFalse: [ 
			  self isBinary
				  ifTrue: [ 
					  BlockClosure
						  currify: [ :i :j | i perform: self with: j ]
						  numArgs: 2 ]
				  ifFalse: [ 
				  BlockClosure currify: self numArgs: (self occurrencesOf: $:) + 1 ] ]
]

{ #category : #'*Containers-Category' }
Symbol >> valueWithArguments: args [

	^ self value: args first withArguments: args allButFirst
]

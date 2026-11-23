"
I am what `asNothingMaybe` answers: my `asCategory` answers a `CTNothingMaybeCategory` and leaves my object out.
"
Class {
	#name : #CTCategoryNothingMaybe,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryNothingMaybe >> asCategory [

	^ CTNothingMaybeCategory on: nil
]

"
I am what `asProbabilityDistribution` answers: my `asCategory` answers a `CTProbabilityDistributionCategory` on the category of my collection, whose elements are associations from an object to its probability.
"
Class {
	#name : #CTCategoryProbabilityDistribution,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryProbabilityDistribution >> asCategory [

	^ CTProbabilityDistributionCategory on: self object asCategory
]

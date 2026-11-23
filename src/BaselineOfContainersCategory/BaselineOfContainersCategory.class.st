"
I am the baseline of `Containers-Category`: I load the packages `Containers-Category` and `Containers-Category-Tests`, and the project `Containers-Essentials` that they require.

```smalltalk
Metacello new
	baseline: 'ContainersCategory';
	repository: 'github://massimo-nocentini/Containers-Category:master/src';
	load
```
"
Class {
	#name : #BaselineOfContainersCategory,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersCategory
}

{ #category : #baselines }
BaselineOfContainersCategory >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'ContainersEssentials'
			with: [
			spec repository: 'github://massimo-nocentini/Containers-Essentials:master' ].

		spec
			package: 'Containers-Category'
			with: [ spec requires: #( 'ContainersEssentials' ) ];
			package: 'Containers-Category-Tests'
			with: [ spec requires: #( 'Containers-Category' ) ] ]
]

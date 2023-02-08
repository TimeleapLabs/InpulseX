<button><slot /></button>

<style>
	button {
		font-size: 1.2rem;
		padding: 10px 30px;
		margin: 0 10px;
		background: radial-gradient(#257ee4 30%, #104e95);
		border-color: #257ee4;
		border-style: inset;
		border-radius: 8px;
		font-weight: 600;
		text-transform: uppercase;
	}
	button:hover {
		background: radial-gradient(#f307ae 30%, #730351);
		border-color: #f307ae;
		color: #fe0;
		transition: color 0.8s ease 0.1s, background 0.8s ease 0.1s;
	}
	button:active {
		transform: scale(0.99) translateY(2px);
	}
</style>

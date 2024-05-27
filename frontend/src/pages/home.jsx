import { useGlobalState } from "../hooks";

function Home() {
	const { state } = useGlobalState();

	const { movies } = state;

	return (
		<div>
			{movies.map((movie, index) => {
				return (
					<div key={index}>
						<h1>{movie.title}</h1>
						<p>{movie.description}</p>
					</div>
				);
			})}
		</div>
	);
}

export default Home;

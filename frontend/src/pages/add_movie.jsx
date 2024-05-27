import { useGlobalState } from "../hooks";
import { useForm } from "react-hook-form";

function AddMoviePage() {
	const { action } = useGlobalState();
	const { addMovie } = action;
	const AddMovieForm = () => {
		const {
			register,
			handleSubmit,
			// formState: { errors },
		} = useForm();

		const onSubmit = (data) => addMovie.exec(data["youtube_url"]);
		return (
			<div>
				Add movie
				{/* <a>{errors}</a> */}
				<form onSubmit={handleSubmit(onSubmit)}>
					<input {...register("youtube_url")} />
					<button type="submit">Submit</button>
				</form>
			</div>
		);
	};

	return (
		<div>
			<AddMovieForm />
		</div>
	);
}

export default AddMoviePage;

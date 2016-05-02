package filmr.domain;

import javax.persistence.*;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import java.util.List;

@Entity
public class Repertoire {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToMany
	private List<Movie> movies;

    public Long getId() {
        return id;
    }

    public List<Movie> getMovies() {
        return movies;
    }

    public void setMovies(List<Movie> movies) {
        this.movies = movies;
    }
    
    @Override
    public boolean equals(Object object){
        if (object == null) {
            return false;
        }
        if(!(object instanceof Repertoire)){
            return false;
        }
        final Repertoire repertoire = (Repertoire)object;
        return new EqualsBuilder()
                .append(id,repertoire.getId())
                .append(movies,repertoire.getMovies())
                .isEquals();

    }
    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 31)
                .append(id)
                .append(movies)
                .toHashCode();
    }

	/*@Override
	public String toString() {
		return "Repertoire [id=" + id + ", movies=" + movies + "]";
	}*/
    
    
    
}

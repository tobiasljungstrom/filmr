package filmr.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import javax.persistence.*;

@Entity
public class Seat {
	@Id
	@GeneratedValue( strategy = GenerationType.AUTO)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "row_id")
	@JsonIgnore
	private Row row;

	private String seatLabel;

	@Enumerated(EnumType.STRING)
	private SeatState state;
	
	@Transient
	private Boolean isBookedForShowing;

	
	public Seat() {}


	public Boolean getIsBookedForShowing() {
		return isBookedForShowing;
	}

	public void setIsBookedForShowing(Boolean isBookedForShowing) {
		this.isBookedForShowing = isBookedForShowing;
	}
	public String getSeatLabel() {
		return seatLabel;
	}

	public void setSeatLabel(String seatLabel) {
		this.seatLabel = seatLabel;
	}

	public SeatState getState() {
		return state;
	}

	public void setState(SeatState state) {
		this.state = state;
	}

	public Row getRow() {
		return row;
	}

	public void setRow(Row row) {
		this.row = row;
	}

	public Long getId() {
		return id;
	}
	
    @Override
    public boolean equals(Object object){
        if (object == null) {
            return false;
        }
        if(!(object instanceof Seat)){
            return false;
        }
        final Seat seat = (Seat)object;
        return new EqualsBuilder()
                .append(id,seat.getId())
                .append(row,seat.getRow())
                .isEquals();
    }
    
	@Override
    public int hashCode() {
        return new HashCodeBuilder(17, 31)
                .append(id)
                .append(row)
                .toHashCode();
    }

	
	
	
}

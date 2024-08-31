import { LightningElement } from 'lwc';
import getWeatherDetails from '@salesforce/apex/WeatherController.getWeatherDetails'
export default class Weather extends LightningElement {

    cityName=''
    data 
    error 
    dummy=[1,2,3]
    isVisible=false;
    handleChange(e){
        this.cityName = e.target.value
    }

    handleClick(){
        this.isVisible = true;
        getWeatherDetails({city : this.cityName})
        .then((data)=>{
            this.isVisible = false
            if(data.temp!=null){
                console.log(data)
                this.data = data;
                this.error = undefined
            }else{
               
                this.error = 'Please enter a valid city name.'
                this.data = undefined
            }
            
        })
        .catch((e)=>{
            console.log(e)
            this.error = e
            this.data = undefined
        })
    }
    


}